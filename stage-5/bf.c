#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <openssl/sha.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <omp.h>

#include "decrypt.h"
#include "keys.h"

#define PLAIN_TEXT_LOOKUP_SZ 32

void sha256sum(const char *data, int len, char output[65]) {
    int i;
    uint8_t hash[SHA256_DIGEST_LENGTH];
    SHA256_CTX sha256;
    SHA256_Init(&sha256);
    SHA256_Update(&sha256, data, len);
    SHA256_Final(hash, &sha256);

    for (i = 0; i < SHA256_DIGEST_LENGTH; i++) {
        sprintf(output + (i * 2), "%02x", hash[i]);
    }
    output[64] = 0;
}

const char *cipher_sha256 = "a5790b4427bc13e4f4e9f524c684809ce96cd2f724e29d94dc999ec25e166a81";
const char *plain_sha256 = "9128135129d2be652809f5a1d337211affad91ed5827474bf9bd7e285ecef321";

void bf(const char *path) {
    int fd, ret, hcount = 0;
    struct stat st;
    off_t size;
    char *cipher_bf = NULL;
    char sha256[65];
    int i;
    int keyfound;
    uint8_t hchars[4] = { '-', '\\', '|', '/' };

    fd = open(path, O_RDONLY);
    if (fd == -1) {
        perror("open failed");
        exit(EXIT_FAILURE);
    }
    ret = fstat(fd, &st);
    if (ret == -1) {
        perror("fstat");
        exit(EXIT_FAILURE);
    }
    size = st.st_size;

    cipher_bf = malloc(size);
    if (!cipher_bf) {
        perror("malloc cipher");
        goto finish;
    }

    ret = read(fd, cipher_bf, size);
    if (ret != size) {
        printf("error during read\n");
        goto finish;
    }
    close(fd);

    sha256sum(cipher_bf, size, sha256);
    if (strcmp(sha256, cipher_sha256) != 0) {
        printf("wrong sha256: %s\n", sha256);
        goto finish;
    }
#pragma omp parallel
    {
#pragma omp barrier
        if (omp_get_thread_num() == 0)
            fprintf(stderr, "[+] starting %d threads\n", omp_get_num_threads());
    }

    keyfound = 0;
    printf("[+] testing %d keys\n", KEYS_COUNT);
#pragma omp parallel
    for (i = 0; i < KEYS_COUNT; i++) {
        char *key;
        int j, k, l, out_fd, thread_id;
        char *plain_bf = NULL;
        char plain_text_lookup[PLAIN_TEXT_LOOKUP_SZ];
        char sha256[65];

        if (keyfound == 1) {
            i = KEYS_COUNT;
            continue;
        }
        key = keys[i];

        thread_id = omp_get_thread_num();
        if (thread_id == 0) {
            fprintf(stderr, "\r[%c] key = ", hchars[hcount++ % 4]);
            for (l = 0; l < 10; l++)
                fprintf(stderr, "%2.2x", key[l] & 0xff);
            fprintf(stderr, "????");
            fflush(stderr);
        }

        for (j = 0; j < 256; j++) {
            key[10] = j;

            for (k = 0; k < 256; k++) {
                key[11] = k;

                decrypt(key, cipher_bf, plain_text_lookup, PLAIN_TEXT_LOOKUP_SZ);

                if (!memmem(plain_text_lookup, PLAIN_TEXT_LOOKUP_SZ,
                            "\xFF\xFF\xFF\xFF", 4))
                    continue;

                if (!plain_bf)
                    plain_bf = malloc(size);

                decrypt(key, cipher_bf, plain_bf, size);
                sha256sum(plain_bf, size, sha256);

                if (!strncmp(sha256, plain_sha256, 64))
#pragma omp critical
                {
                    keyfound = 1;
                    fprintf(stderr, "\r[!] key = ");
                    for (l = 0; l < 12; l++)
                        fprintf(stderr, "%2.2x", key[l] & 0xff);

                    fprintf(stderr, "\n[+] result saved in congratulations.tar.bz2\n");
                    out_fd = open("congratulations.tar.bz2", O_WRONLY | O_CREAT,
                            S_IRUSR | S_IWUSR);
                    ret = write(out_fd, plain_bf, size);
                    if (ret != size)
                        perror("write:");
                    close(out_fd);
                }
            }
        }
    }

finish:
    if (cipher_bf)
        free(cipher_bf);
}

int main(int argc, char **argv) {
    if (self_test(2) != 0) {
        fprintf(stderr, "self-test failed\n");
        exit(EXIT_FAILURE);
    }
    printf("[+] self-test passed\n");

    if (argc != 2) {
        printf("usage: %s encrypted.bin\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    bf(argv[1]);

    return EXIT_SUCCESS;
}
