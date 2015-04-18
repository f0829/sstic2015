#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <openssl/sha.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

#include "keys.h"

#define DEBUG 0 

void DumpHex(const void* data, size_t size) {
	char ascii[17];
	size_t i, j;
	ascii[16] = '\0';
	for (i = 0; i < size; ++i) {
		printf("%02X ", ((unsigned char*)data)[i]);
		if (((unsigned char*)data)[i] >= ' ' && ((unsigned char*)data)[i] <= '~') {
			ascii[i % 16] = ((unsigned char*)data)[i];
		} else {
			ascii[i % 16] = '.';
		}
		if ((i+1) % 8 == 0 || i+1 == size) {
			printf(" ");
			if ((i+1) % 16 == 0) {
				printf("|  %s \n", ascii);
			} else if (i+1 == size) {
				ascii[(i+1) % 16] = '\0';
				if ((i+1) % 16 <= 8) {
					printf(" ");
				}
				for (j = (i+1) % 16; j < 16; ++j) {
					printf("   ");
				}
				printf("|  %s \n", ascii);
			}
		}
	}
}


/* Tested, OK
   l 7ff80000 transputer_4.bin
   i 7ff8000c
   s i 7ff80003
   g
   w 2 5453532a
   w 3 322d4349
   w 4 2a353130
   s i 7ff80009
   g
   result => 0xcf
   */

typedef struct tr_ctx {
  uint8_t t4_st;
  uint8_t t5_st;
  uint16_t t6_st;
  uint8_t t8_idx;
  uint8_t t8_st[4][12];
  uint8_t t10_idx;
  uint8_t t10_st[4][12];
  uint8_t t12_st[12];

} tr_ctx_t;

inline uint8_t transputer_4(const uint8_t *key, tr_ctx_t *ctx) {
	int i;

	for (i = 0; i < 12; i++) {
		ctx->t4_st += key[i];
	}

	return ctx->t4_st;
}

/* Tested, OK
   l 7ff80000 transputer_5.bin
   i 7ff8000c
   s i 7ff80003
   g


   w 2 5453532a
   w 3 322d4349
   w 4 2a353130
   s i 7ff80009
   g


   result => 0x75
   */
inline uint8_t transputer_5(const uint8_t *key, tr_ctx_t *ctx) {
	int i;

	for (i = 0; i < 12; i++) {
		ctx->t5_st ^= key[i];
	}

	return ctx->t5_st;
}

/* Tested, OK
   l 7ff80000 transputer_6.bin
   i 7ff8000c
   s i 7ff80003
   g


   w 4 5453532a
   w 5 322d4349
   w 6 2a353130
   s i 7ff80009
   g


   result => 0x9e
   */

inline uint8_t transputer_6(const uint8_t *key, tr_ctx_t *ctx) {
	uint16_t k1, k2, k3;

	k1 = (ctx->t6_st & 0x8000) >> 0xf;
	k2 = (ctx->t6_st & 0x4000) >> 0xe;

	k2 ^= k1;
	k2 &= 0xffff;

	k3 = (ctx->t6_st << 1);
	k3 &= 0xffff;

	ctx->t6_st = k3 ^ k2;
	ctx->t6_st &= 0xffff;

	return (ctx->t6_st & 0xff);
}

inline uint8_t transputer_1(const uint8_t *key, tr_ctx_t *ctx) {
	uint8_t a, b, c, res;

	a = transputer_4(key, ctx);
	b = transputer_5(key, ctx);
	c = transputer_6(key, ctx);
#if DEBUG
	printf("[T1] T4 : 0x%2.2x T5 : 0x%2.2x T6 : 0x%2.2x\n", a, b, c);
#endif

	res = (a ^ b) ^ c;

	return res;
}


/* Tested, OK
   l 7ff80000 transputer_7.bin
   i 7ff8000c
   s i 7ff80003
   g


   w 4 5453532a
   w 5 322d4349
   w 6 2a353130
   s i 7ff80009
   g

   result => 0xaf
   */

inline uint8_t transputer_7(const uint8_t *key, tr_ctx_t *ctx) {
	uint8_t var_1, var_2, var_3;
	int i;

	var_1 = 0;
	var_2 = 0;
	var_3 = 0;

	for (i = 0; i < 6; i++) {
		var_1 += key[i];
		var_1 &= 0xff;

		var_2 += key[i + 6];
		var_2 &= 0xff;
	}

	var_3 = (var_1 ^ var_2) & 0xff;

	return var_3;
}


/* Tested, OK
   l 7ff80000 transputer_8.bin
   i 7ff8000c
   s i 7ff80003
   g


   w 5 5453532a
   w 6 322d4349
   w 7 2a353130
   s i 7ff80009
   g

   result => 0xcf
   */
inline uint8_t transputer_8(const uint8_t *key, tr_ctx_t *ctx) {
	int i, j;
	uint8_t var_3, var_1;

	memcpy(ctx->t8_st[ctx->t8_idx], key, 12);
	ctx->t8_idx = (ctx->t8_idx + 1) % 4;

	var_3 = 0;
	for (i = 0; i < 4; i++) {
		var_1 = 0;
		for (j = 0; j < 12; j++) {
			var_1 += ctx->t8_st[i][j];
		}
		var_3 = var_1 ^ var_3;
	}

	return var_3;
}

/* Tested, OK
   l 7ff80000 transputer_9.bin
   i 7ff8000c
   s i 7ff80003
   g


   w 2 5453532a
   w 3 322d4349
   w 4 2a353130
   s i 7ff80009
   g


   result => 0x06
   */
inline uint8_t transputer_9(const uint8_t *key, tr_ctx_t *ctx) {
	uint8_t var_1 = 0;
	int i;

	var_1 = 0;

	for (i = 0; i < 12; i++) {
		var_1 ^= (key[i] << (i & 0x7));
		var_1 &= 0xff;
	}

	return var_1;
}

inline uint8_t transputer_2(const uint8_t *key, tr_ctx_t *ctx) {
	uint8_t a, b, c, res;

	a = transputer_7(key, ctx);
	b = transputer_8(key, ctx);
	c = transputer_9(key, ctx);
#if DEBUG
	printf("[T2] T7 : 0x%2.2x T8 : 0x%2.2x T9 : 0x%2.2x\n", a, b, c);
#endif

	res = (a ^ b) ^ c;

	return res;
}


/* ?
   l 7ff80000 transputer_10.bin
   i 7ff8000c
   s i 7ff80003
   g


   w 4 5453532a
   w 5 322d4349
   w 6 2a353130
   s i 7ff80065
   g


*/
inline uint8_t transputer_10(const uint8_t *key, tr_ctx_t *ctx) {
	int i, j;
	uint8_t var_1, res;

	memcpy(ctx->t10_st[ctx->t10_idx], key, 12);
	ctx->t10_idx = (ctx->t10_idx + 1) % 4;

	var_1 = 0;
	for (i = 0; i < 4; i++) {
		var_1 += ctx->t10_st[i][0];
		var_1 &= 0xff;
	}

	i = var_1 & 3;
	j = (var_1 >> 4) % 12;
	res = ctx->t10_st[i][j];

	return res;
}

/*
   l 7ff80000 transputer_11.bin
   i 7ff8000c
   s i 7ff80003
   g


   w 3 5453532a
   w 4 322d4349
   w 5 2a353130
   s i 7ff80030
   g
   */
inline uint8_t transputer_11(const uint8_t *key, tr_ctx_t *ctx) {
	uint8_t var_1;

	var_1 = ctx->t12_st[9] ^ ( ctx->t12_st[5] ^ ctx->t12_st[1] ); /* from T12 */
	var_1 = key[var_1 % 12];
	return var_1;
}

inline uint8_t transputer_12(const uint8_t *key, tr_ctx_t *ctx) {
	uint8_t var_1, var_2;

	memcpy(ctx->t12_st, key, 12);
	var_2 = key[7] ^ (key[3] ^ key[0]); /* from T11 */

	var_1 = key[var_2 % 12];
	return var_1;
}

inline uint8_t transputer_3(const uint8_t *key, tr_ctx_t *ctx) {
	uint8_t a, b, c, res;

	a = transputer_10(key, ctx);
	b = transputer_11(key, ctx);
	c = transputer_12(key, ctx);
#if DEBUG
	printf("[T3] T10: 0x%2.2x T11: 0x%2.2x T12: 0x%2.2x\n", a, b, c);
#endif

	res = (a ^ b) ^ c;

	return res;
}

void transputer_0(const char *key, const char *cipher, int cipher_len, char *plain, tr_ctx_t *ctx) {
	uint8_t current_key[12];
	int i, j;
	uint8_t t1_res, t2_res, t3_res;
	uint8_t res;
	uint8_t a;

	memcpy(current_key, key, 12);

	for (i = 0; i < cipher_len; i++) {
		j = i % 12;
		t1_res = transputer_1(current_key, ctx);
		t2_res = transputer_2(current_key, ctx);
		t3_res = transputer_3(current_key, ctx);

#if DEBUG
		printf("[T0] T1 : 0x%2.2x T2 : 0x%2.2x T3 : 0x%2.2x\n", t1_res, t2_res, t3_res);
#endif

		res = (t1_res ^ t2_res) ^ t3_res;

		a = 2 * current_key[j] + j;
		plain[i] = cipher[i] ^ a;

		current_key[j] = res;
	}
}

void init_ctx(tr_ctx_t *ctx, const uint8_t *key) {
	int i;

	memset(ctx, 0, sizeof(*ctx));

	/* t6 init */
	for (i = 0; i < 12; i++) {
		ctx->t6_st = (ctx->t6_st + key[i]) & 0xffff;
	}
}

void decipher(const char *key, const char *cipher, char *plain, int size) {
	tr_ctx_t ctx;
	init_ctx(&ctx, (const uint8_t *) key);
	transputer_0(key, cipher, size, plain, &ctx);
}

void sha256sum(const char *data, int len, char output[65]) {
	int i;
	uint8_t hash[SHA256_DIGEST_LENGTH];
	SHA256_CTX sha256;
	SHA256_Init(&sha256);
	SHA256_Update(&sha256, data, len);
	SHA256_Final(hash, &sha256);

	for (i = 0; i < SHA256_DIGEST_LENGTH; i++)
	{
		sprintf (output + (i * 2), "%02x", hash[i]);
	}
	output[64] = 0;
}

const char *cipher_sha256 = "a5790b4427bc13e4f4e9f524c684809ce96cd2f724e29d94dc999ec25e166a81";
const char *plain_sha256  = "9128135129d2be652809f5a1d337211affad91ed5827474bf9bd7e285ecef321";

void bf(const char *path, int start, int finish) {
	int fd, ret, out_fd;
	struct stat st;
	off_t size;
	char *cipher_bf = NULL;
	char *plain_bf = NULL;
	char sha256[65];
	char *key;
	int i, j, k;

	printf("start: %d, finish: %d\n", start, finish);

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
	plain_bf = malloc(size);
	if (!plain_bf) {
		perror("malloc plain");
		goto finish;
	}

	ret = read(fd, cipher_bf, size);
	if (ret != size) {
		printf("error during read\n");
		goto finish;
	}
	sha256sum(cipher_bf, size, sha256);
	if (strcmp(sha256, cipher_sha256) != 0) {
		printf("wrong sha256: %s\n", sha256);
		goto finish;
	}

	for (i = 0; i < KEYS_COUNT; i++) {
		printf("i = %d\n", i);
		key = keys[i];
		for (j = start; j < finish; j++) {
			key[10] = j;
			for (k = 0; k < 256; k++) {
				key[11] = k;
				decipher(key, cipher_bf, plain_bf, 32);

				if (memmem(plain_bf, 32, "\xFF\xFF\xFF\xFF", 4) == NULL) {
					continue;
				} else {
					printf("[%d] found FF FF FF in plaintext\n", i);
				}

				decipher(key, cipher_bf, plain_bf, size);
				sha256sum(plain_bf, size, sha256);

				if (strncmp(sha256, plain_sha256, 64) == 0) {
					printf("Key found\n");
					DumpHex(key, 12);
					out_fd = open("decrypted.bin", O_WRONLY | O_CREAT, S_IRWXU);
					ret = write(out_fd, plain_bf, size);
					if (ret != size) {
						perror("write:");
					}
					close(out_fd);

					goto finish;
				}
			}
		}
	}

finish:
	if (cipher_bf)
		free(cipher_bf);
	if (plain_bf)
		free(plain_bf);
	close(fd);
}

int self_test(int count) {
	int ret = 0, i;
	char *test_key = "*SSTIC-2015*";
	char *test_data = "\x1d\x87\xc4\xc4\xe0\xee\x40\x38\x3c\x59\x44\x7f\x23\x79\x8d\x9f\xef\xe7\x4f\xb8\x24\x80\x76\x6e";
	char test_plain[24];
	int test_data_size = 24;

	for (i = 0; i < count && ret == 0; i++) {	
		decipher(test_key, test_data, test_plain, test_data_size);
		ret = strncmp("I love ST20 architecture", test_plain, 24);
	}

	return ret;
}

int main(int argc, char **argv) {
	if (self_test(5) != 0) {
		fprintf(stderr, "self-test failed\n");
		exit(EXIT_FAILURE);
	}
	printf("[+] self-test passed\n");

	if (argc != 4) {
		printf("usage: %s encrypted.bin start finish\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	bf(argv[1], atoi(argv[2]), atoi(argv[3]));


	return EXIT_SUCCESS;
}
