#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define DEBUG 0

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

inline uint8_t transputer_4(const uint8_t * key, tr_ctx_t * ctx) {
    int i;

    for (i = 0; i < 12; i++)
        ctx->t4_st += key[i];

    return ctx->t4_st;
}

inline uint8_t transputer_5(const uint8_t * key, tr_ctx_t * ctx) {
    int i;

    for (i = 0; i < 12; i++)
        ctx->t5_st ^= key[i];

    return ctx->t5_st;
}

inline uint8_t transputer_6(const uint8_t * key, tr_ctx_t * ctx) {
    uint16_t k1, k2, k3;

    k1 = (ctx->t6_st & 0x8000) >> 0xf;
    k2 = (ctx->t6_st & 0x4000) >> 0xe;

    k2 ^= k1;
    k3 = (ctx->t6_st << 1);

    ctx->t6_st = k3 ^ k2;

    return ctx->t6_st & 0xff;
}

inline uint8_t transputer_1(const uint8_t * key, tr_ctx_t * ctx) {
    uint8_t a, b, c;

    a = transputer_4(key, ctx);
    b = transputer_5(key, ctx);
    c = transputer_6(key, ctx);
#if DEBUG
    printf("[T1] T4 : 0x%2.2x T5 : 0x%2.2x T6 : 0x%2.2x\n", a, b, c);
#endif

    return (a ^ b) ^ c;
}

inline uint8_t transputer_7(const uint8_t * key, tr_ctx_t * ctx) {
    uint8_t var_1, var_2;
    int i;

    var_1 = 0; var_2 = 0;

    for (i = 0; i < 6; i++) {
        var_1 += key[i];
        var_2 += key[i + 6];
    }

    return var_1 ^ var_2;
}

inline uint8_t transputer_8(const uint8_t * key, tr_ctx_t * ctx) {
    int i, j;
    uint8_t var_3, var_1;

    memcpy(ctx->t8_st[ctx->t8_idx], key, 12);
    ctx->t8_idx = (ctx->t8_idx + 1) % 4;

    var_3 = 0;
    for (i = 0; i < 4; i++) {
        var_1 = 0;
        for (j = 0; j < 12; j++)
            var_1 += ctx->t8_st[i][j];

        var_3 = var_1 ^ var_3;
    }

    return var_3;
}

inline uint8_t transputer_9(const uint8_t * key, tr_ctx_t * ctx) {
    uint8_t var_1;
    int i;

    var_1 = 0;
    for (i = 0; i < 12; i++)
        var_1 ^= (key[i] << (i & 0x7));

    return var_1;
}

inline uint8_t transputer_2(const uint8_t * key, tr_ctx_t * ctx) {
    uint8_t a, b, c;

    a = transputer_7(key, ctx);
    b = transputer_8(key, ctx);
    c = transputer_9(key, ctx);
#if DEBUG
    printf("[T2] T7 : 0x%2.2x T8 : 0x%2.2x T9 : 0x%2.2x\n", a, b, c);
#endif

    return (a ^ b) ^ c;
}

inline uint8_t transputer_10(const uint8_t * key, tr_ctx_t * ctx) {
    int i, j;
    uint8_t var_1;

    memcpy(ctx->t10_st[ctx->t10_idx], key, 12);
    ctx->t10_idx = (ctx->t10_idx + 1) % 4;

    var_1 = 0;
    for (i = 0; i < 4; i++) {
        var_1 += ctx->t10_st[i][0];
    }

    i = var_1 & 3;
    j = (var_1 >> 4) % 12;

    return ctx->t10_st[i][j];
}

inline uint8_t transputer_11(const uint8_t * key, tr_ctx_t * ctx) {
    uint8_t var_1;

    var_1 = ctx->t12_st[9] ^ (ctx->t12_st[5] ^ ctx->t12_st[1]);	/* from T12 */
    memcpy(ctx->t12_st, key, 12);

    return key[var_1 % 12];
}

inline uint8_t transputer_12(const uint8_t * key, tr_ctx_t * ctx) {
    uint8_t var_2;

    var_2 = key[7] ^ (key[3] ^ key[0]);	/* from T11 */

    return key[var_2 % 12];
}

inline uint8_t transputer_3(const uint8_t * key, tr_ctx_t * ctx) {
    uint8_t a, b, c;

    a = transputer_10(key, ctx);
    b = transputer_11(key, ctx);
    c = transputer_12(key, ctx);
#if DEBUG
    printf("[T3] T10: 0x%2.2x T11: 0x%2.2x T12: 0x%2.2x\n", a, b, c);
#endif

    return (a ^ b) ^ c;
}

void
transputer_0(const char *key, const char *cipher, int cipher_len, char *plain, tr_ctx_t * ctx) {
    uint8_t current_key[12];
    int i;
    uint8_t t1_res, t2_res, t3_res;

    memcpy(current_key, key, 12);

    for (i = 0; i < cipher_len; i++) {
        t1_res = transputer_1(current_key, ctx);
        t2_res = transputer_2(current_key, ctx);
        t3_res = transputer_3(current_key, ctx);

#if DEBUG
        printf("[T0] T1 : 0x%2.2x T2 : 0x%2.2x T3 : 0x%2.2x\n", t1_res, t2_res, t3_res);
#endif

        plain[i] = cipher[i] ^ (2 * current_key[i % 12] + i % 12);

        current_key[i % 12] = (t1_res ^ t2_res) ^ t3_res;
    }
}

void init_ctx(tr_ctx_t * ctx, const uint8_t * key) {
    int i;

    memset(ctx, 0, sizeof(struct tr_ctx));

    /* t6 init */
    for (i = 0; i < 12; i++)
        ctx->t6_st = (ctx->t6_st + key[i]) & 0xffff;
}

void decipher(const char *key, const char *cipher, char *plain, int size) {
    tr_ctx_t ctx;
    init_ctx(&ctx, (const uint8_t *)key);
    transputer_0(key, cipher, size, plain, &ctx);
}

int self_test(int count) {
    int ret = 0, i;
    char *key = "*SSTIC-2015*";
    char *cipher = "\x1d\x87\xc4\xc4\xe0\xee\x40\x38\x3c\x59\x44\x7f\x23\x79\x8d\x9f\xef\xe7\x4f\xb8\x24\x80\x76\x6e";
    char plain[24];
    int data_size = 24;

    for (i = 0; i < count && ret == 0; i++) {
        decipher(key, cipher, plain, data_size);
        ret = strncmp("I love ST20 architecture", plain, data_size);
    }

    return ret;
}

#ifdef _STANDALONE_
int main(int argc, char **argv) {
    if (self_test(2) != 0) {
        fprintf(stderr, "self-test failed\n");
        exit(EXIT_FAILURE);
    }
    printf("[+] self-test passed\n");

    return EXIT_SUCCESS;
}
#endif
