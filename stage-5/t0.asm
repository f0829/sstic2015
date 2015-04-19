
; New subroutine 0+d; References: 0, Local Vars: 76
00000000: 64 b4     sub_0:        ajw #-4c         ; adjust workspace - Move workspace pointer
00000002: 40                      ldc #0           ; load constant - A = n, B=A, C=B
00000003: d1                      stl #1 [var_1]   ; store local - workspace[n] = A, A=B, B=C
00000004: 40                      ldc #0           ; load constant - A = n, B=A, C=B
00000005: d3                      stl #3 [var_3]   ; store local - workspace[n] = A, A=B, B=C
00000006: 24 f2                   mint             ; minimum integer - A = MostNeg
00000008: 24 20 50                ldnlp #400       ; load non-local pointer - A = &A[n]
0000000b: 23 fc                   gajw             ; general adjust workspace - Wptr <=> A

; New subroutine d+eb; References: 0, Local Vars: 76
0000000d: 64 b4     sub_d:        ajw #-4c         ; adjust workspace - Move workspace pointer
0000000f: 2c 49                   ldc #c9          ; load constant - A = n, B=A, C=B
00000011: 21 fb                   ldpi [str_dc]    ; Load pointer to instruction - A = next instruction + A
00000013: 24 f2                   mint             ; minimum integer - A = MostNeg
00000015: 48                      ldc #8           ; load constant - A = n, B=A, C=B
00000016: fb                      out              ; output message - A bytes to channel B from address C
00000017: 24 19     loc_17:       ldlp #49 [&var_73]   ; load local pointer - A = &workspace[n], B=A, C=B
00000019: 24 f2                   mint             ; minimum integer - A = MostNeg
0000001b: 54                      ldnlp #4         ; load non-local pointer - A = &A[n]
0000001c: 4c                      ldc #c           ; load constant - A = n, B=A, C=B
0000001d: f7                      in               ; input message - Read A bytes from channel B to addr C
0000001e: 24 79                   ldl #49 [var_73]  ; load local - A = workspace[n], B=A, C=B
00000020: 21 a5                   cj loc_37        ; conditional jump - jump if A = 0
00000022: 2c 4d                   ldc #cd          ; load constant - A = n, B=A, C=B
00000024: 21 fb                   ldpi [loc_f3]    ; Load pointer to instruction - A = next instruction + A
00000026: 24 f2                   mint             ; minimum integer - A = MostNeg
00000028: 54                      ldnlp #4         ; load non-local pointer - A = &A[n]
00000029: 24 79                   ldl #49 [var_73]  ; load local - A = workspace[n], B=A, C=B
0000002b: f7                      in               ; input message - Read A bytes from channel B to addr C
0000002c: 2c 43                   ldc #c3          ; load constant - A = n, B=A, C=B
0000002e: 21 fb                   ldpi [loc_f3]    ; Load pointer to instruction - A = next instruction + A
00000030: 24 7a                   ldl #4a [var_74]  ; load local - A = workspace[n], B=A, C=B
00000032: 24 79                   ldl #49 [var_73]  ; load local - A = workspace[n], B=A, C=B
00000034: fb                      out              ; output message - A bytes to channel B from address C
00000035: 61 00                   j loc_17         ; jump - Unconditional relative jump
00000037: 24 19     loc_37:       ldlp #49 [&var_73]   ; load local pointer - A = &workspace[n], B=A, C=B
00000039: 24 f2                   mint             ; minimum integer - A = MostNeg
0000003b: 51                      ldnlp #1         ; load non-local pointer - A = &A[n]
0000003c: 4c                      ldc #c           ; load constant - A = n, B=A, C=B
0000003d: fb                      out              ; output message - A bytes to channel B from address C
0000003e: 24 19                   ldlp #49 [&var_73]   ; load local pointer - A = &workspace[n], B=A, C=B
00000040: 24 f2                   mint             ; minimum integer - A = MostNeg
00000042: 52                      ldnlp #2         ; load non-local pointer - A = &A[n]
00000043: 4c                      ldc #c           ; load constant - A = n, B=A, C=B
00000044: fb                      out              ; output message - A bytes to channel B from address C
00000045: 24 19                   ldlp #49 [&var_73]   ; load local pointer - A = &workspace[n], B=A, C=B
00000047: 24 f2                   mint             ; minimum integer - A = MostNeg
00000049: 53                      ldnlp #3         ; load non-local pointer - A = &A[n]
0000004a: 4c                      ldc #c           ; load constant - A = n, B=A, C=B
0000004b: fb                      out              ; output message - A bytes to channel B from address C
0000004c: 29 44                   ldc #94          ; load constant - A = n, B=A, C=B
0000004e: 21 fb                   ldpi [str_e4]    ; Load pointer to instruction - A = next instruction + A
00000050: 24 f2                   mint             ; minimum integer - A = MostNeg
00000052: 48                      ldc #8           ; load constant - A = n, B=A, C=B
00000053: fb                      out              ; output message - A bytes to channel B from address C
00000054: 12                      ldlp #2 [&var_2]  ; load local pointer - A = &workspace[n], B=A, C=B
00000055: 24 f2                   mint             ; minimum integer - A = MostNeg
00000057: 54                      ldnlp #4         ; load non-local pointer - A = &A[n]
00000058: 44                      ldc #4           ; load constant - A = n, B=A, C=B
00000059: f7                      in               ; input message - Read A bytes from channel B to addr C
0000005a: 15                      ldlp #5 [&var_5]  ; load local pointer - A = &workspace[n], B=A, C=B
0000005b: 24 f2                   mint             ; minimum integer - A = MostNeg
0000005d: 54                      ldnlp #4         ; load non-local pointer - A = &A[n]
0000005e: 4c                      ldc #c           ; load constant - A = n, B=A, C=B
0000005f: f7                      in               ; input message - Read A bytes from channel B to addr C
00000060: 28 48                   ldc #88          ; load constant - A = n, B=A, C=B
00000062: 21 fb                   ldpi [str_ec]    ; Load pointer to instruction - A = next instruction + A
00000064: 24 f2                   mint             ; minimum integer - A = MostNeg
00000066: 48                      ldc #8           ; load constant - A = n, B=A, C=B
00000067: fb                      out              ; output message - A bytes to channel B from address C
00000068: 13                      ldlp #3 [&var_3]  ; load local pointer - A = &workspace[n], B=A, C=B
00000069: 24 f2                   mint             ; minimum integer - A = MostNeg
0000006b: 54                      ldnlp #4         ; load non-local pointer - A = &A[n]
0000006c: 41                      ldc #1           ; load constant - A = n, B=A, C=B
0000006d: f7                      in               ; input message - Read A bytes from channel B to addr C
0000006e: 19                      ldlp #9 [&var_9]  ; load local pointer - A = &workspace[n], B=A, C=B
0000006f: 24 f2                   mint             ; minimum integer - A = MostNeg
00000071: 54                      ldnlp #4         ; load non-local pointer - A = &A[n]
00000072: 13                      ldlp #3 [&var_3]  ; load local pointer - A = &workspace[n], B=A, C=B
00000073: f1                      lb               ; load byte - Load byte addressed by A into A
00000074: f7                      in               ; input message - Read A bytes from channel B to addr C
00000075: 40                      ldc #0           ; load constant - A = n, B=A, C=B
00000076: d4                      stl #4 [var_4]   ; store local - workspace[n] = A, A=B, B=C
00000077: 11        loc_77:       ldlp #1 [&var_1]  ; load local pointer - A = &workspace[n], B=A, C=B
00000078: 24 f2                   mint             ; minimum integer - A = MostNeg
0000007a: 54                      ldnlp #4         ; load non-local pointer - A = &A[n]
0000007b: 41                      ldc #1           ; load constant - A = n, B=A, C=B
0000007c: f7                      in               ; input message - Read A bytes from channel B to addr C
0000007d: 15                      ldlp #5 [&var_5]  ; load local pointer - A = &workspace[n], B=A, C=B
0000007e: 24 f2                   mint             ; minimum integer - A = MostNeg
00000080: 51                      ldnlp #1         ; load non-local pointer - A = &A[n]
00000081: 4c                      ldc #c           ; load constant - A = n, B=A, C=B
00000082: fb                      out              ; output message - A bytes to channel B from address C
00000083: 15                      ldlp #5 [&var_5]  ; load local pointer - A = &workspace[n], B=A, C=B
00000084: 24 f2                   mint             ; minimum integer - A = MostNeg
00000086: 52                      ldnlp #2         ; load non-local pointer - A = &A[n]
00000087: 4c                      ldc #c           ; load constant - A = n, B=A, C=B
00000088: fb                      out              ; output message - A bytes to channel B from address C
00000089: 15                      ldlp #5 [&var_5]  ; load local pointer - A = &workspace[n], B=A, C=B
0000008a: 24 f2                   mint             ; minimum integer - A = MostNeg
0000008c: 53                      ldnlp #3         ; load non-local pointer - A = &A[n]
0000008d: 4c                      ldc #c           ; load constant - A = n, B=A, C=B
0000008e: fb                      out              ; output message - A bytes to channel B from address C
0000008f: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
00000090: 81                      adc #1           ; add constant - Add to A with carry check
00000091: 24 f2                   mint             ; minimum integer - A = MostNeg
00000093: 55                      ldnlp #5         ; load non-local pointer - A = &A[n]
00000094: 41                      ldc #1           ; load constant - A = n, B=A, C=B
00000095: f7                      in               ; input message - Read A bytes from channel B to addr C
00000096: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
00000097: 82                      adc #2           ; add constant - Add to A with carry check
00000098: 24 f2                   mint             ; minimum integer - A = MostNeg
0000009a: 56                      ldnlp #6         ; load non-local pointer - A = &A[n]
0000009b: 41                      ldc #1           ; load constant - A = n, B=A, C=B
0000009c: f7                      in               ; input message - Read A bytes from channel B to addr C
0000009d: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
0000009e: 83                      adc #3           ; add constant - Add to A with carry check
0000009f: 24 f2                   mint             ; minimum integer - A = MostNeg
000000a1: 57                      ldnlp #7         ; load non-local pointer - A = &A[n]
000000a2: 41                      ldc #1           ; load constant - A = n, B=A, C=B
000000a3: f7                      in               ; input message - Read A bytes from channel B to addr C
000000a4: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
000000a5: 81                      adc #1           ; add constant - Add to A with carry check
000000a6: f1                      lb               ; load byte - Load byte addressed by A into A
000000a7: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
000000a8: 82                      adc #2           ; add constant - Add to A with carry check
000000a9: f1                      lb               ; load byte - Load byte addressed by A into A
000000aa: 23 f3                   xor              ; exclusive or - A = A^B, B=C
000000ac: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
000000ad: 83                      adc #3           ; add constant - Add to A with carry check
000000ae: f1                      lb               ; load byte - Load byte addressed by A into A
000000af: 23 f3                   xor              ; exclusive or - A = A^B, B=C
000000b1: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
000000b2: 81                      adc #1           ; add constant - Add to A with carry check
000000b3: 23 fb                   sb               ; store byte - *A = B & 0xff
000000b5: 11                      ldlp #1 [&var_1]  ; load local pointer - A = &workspace[n], B=A, C=B
000000b6: f1                      lb               ; load byte - Load byte addressed by A into A
000000b7: 74                      ldl #4 [var_4]   ; load local - A = workspace[n], B=A, C=B
000000b8: 15                      ldlp #5 [&var_5]  ; load local pointer - A = &workspace[n], B=A, C=B
000000b9: f2                      bsub             ; Byte subscript - A = A + B
000000ba: f1                      lb               ; load byte - Load byte addressed by A into A
000000bb: 74                      ldl #4 [var_4]   ; load local - A = workspace[n], B=A, C=B
000000bc: 2c f1                   ssub             ; sixteen subscript - A = A + 2B
000000be: 23 f3                   xor              ; exclusive or - A = A^B, B=C
000000c0: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
000000c1: 23 fb                   sb               ; store byte - *A = B & 0xff
000000c3: 10                      ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
000000c4: 81                      adc #1           ; add constant - Add to A with carry check
000000c5: f1                      lb               ; load byte - Load byte addressed by A into A
000000c6: 74                      ldl #4 [var_4]   ; load local - A = workspace[n], B=A, C=B
000000c7: 15                      ldlp #5 [&var_5]  ; load local pointer - A = &workspace[n], B=A, C=B
000000c8: f2                      bsub             ; Byte subscript - A = A + B
000000c9: 23 fb                   sb               ; store byte - *A = B & 0xff
000000cb: 74                      ldl #4 [var_4]   ; load local - A = workspace[n], B=A, C=B
000000cc: 81                      adc #1           ; add constant - Add to A with carry check
000000cd: 25 fa                   dup              ; duplicate top of stack
000000cf: d4                      stl #4 [var_4]   ; store local - workspace[n] = A, A=B, B=C
000000d0: cc                      eqc #c           ; equals constant - A = (A == Constant)
000000d1: a3                      cj loc_d5        ; conditional jump - jump if A = 0
000000d2: 80                      adc #0           ; add constant - Add to A with carry check
000000d3: 40                      ldc #0           ; load constant - A = n, B=A, C=B
000000d4: d4                      stl #4 [var_4]   ; store local - workspace[n] = A, A=B, B=C
000000d5: 10        loc_d5:       ldlp #0 [&var_0]  ; load local pointer - A = &workspace[n], B=A, C=B
000000d6: 24 f2                   mint             ; minimum integer - A = MostNeg
000000d8: 41                      ldc #1           ; load constant - A = n, B=A, C=B
000000d9: fb                      out              ; output message - A bytes to channel B from address C
000000da: 66 0b                   j loc_77         ; jump - Unconditional relative jump
000000dc: **        str_dc:      .string "Boot ok"
000000e4: **        str_e4:      .string "Code Ok"
000000ec: **        str_ec:      .string "Decrypt"
000000f4: 24 bc                   ajw #4c          ; adjust workspace - Move workspace pointer
000000f6: 22 f0                   ret              ; return
