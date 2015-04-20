
; New subroutine 0+9; References: 0, Local Vars: 8
00000000: 60 b8     sub_0:        ajw #-8       ; réserve 8 variables locales
00000002: 24 f2                   mint          ; A = MostNeg
00000004: 24 20 50                ldnlp #400    ; A = MostNeg @ 0x400
00000007: 23 fc                   gajw          ; Wptr = MostNeg @ 0x400

; New subroutine 9+67; References: 0, Local Vars: 8
00000009: 60 b8     sub_9:        ajw #-8           ; réserve 8 variables locales
0000000b: 15        loc_b:        ldlp #5 [&var_5]
0000000c: 24 f2                   mint 
0000000e: 54                      ldnlp #4
0000000f: 4c                      ldc #c
00000010: f7                      in                ; in(12, MostNeg @ 4, &var_5)
00000011: 75                      ldl #5 [var_5]
00000012: 21 a2                   cj loc_26         ; saute à loc_26 si var_5 == 0
00000014: 25 44                   ldc #54       
00000016: 21 fb                   ldpi [loc_6c]
00000018: 24 f2                   mint 
0000001a: 54                      ldnlp #4
0000001b: 75                      ldl #5 [var_5]
0000001c: f7                      in                ; in(var_5, MostNeg @ 4, loc_6c)
0000001d: 24 4b                   ldc #4b
0000001f: 21 fb                   ldpi [loc_6c]
00000021: 76                      ldl #6 [var_6]
00000022: 75                      ldl #5 [var_5]
00000023: fb                      out               ; out(var_5, var_6, loc_6c)
00000024: 61 05                   j loc_b
00000026: 11        loc_26:       ldlp #1 [&var_1]
00000027: 24 f2                   mint 
00000029: 54                      ldnlp #4
0000002a: 4c                      ldc #c
0000002b: f7                      in 
0000002c: 11                      ldlp #1 [&var_1]
0000002d: 24 f2                   mint 
0000002f: 51                      ldnlp #1
00000030: 4c                      ldc #c
00000031: fb                      out 
00000032: 11                      ldlp #1 [&var_1]
00000033: 24 f2                   mint 
00000035: 52                      ldnlp #2
00000036: 4c                      ldc #c
00000037: fb                      out 
00000038: 11                      ldlp #1 [&var_1]
00000039: 24 f2                   mint 
0000003b: 53                      ldnlp #3
0000003c: 4c                      ldc #c
0000003d: fb                      out 
0000003e: 10                      ldlp #0 [&var_0]
0000003f: 81                      adc #1
00000040: 24 f2                   mint 
00000042: 55                      ldnlp #5
00000043: 41                      ldc #1
00000044: f7                      in 
00000045: 10                      ldlp #0 [&var_0]
00000046: 82                      adc #2
00000047: 24 f2                   mint 
00000049: 56                      ldnlp #6
0000004a: 41                      ldc #1
0000004b: f7                      in 
0000004c: 10                      ldlp #0 [&var_0]
0000004d: 83                      adc #3
0000004e: 24 f2                   mint 
00000050: 57                      ldnlp #7
00000051: 41                      ldc #1
00000052: f7                      in 
00000053: 10                      ldlp #0 [&var_0]
00000054: 81                      adc #1
00000055: f1                      lb 
00000056: 10                      ldlp #0 [&var_0]
00000057: 82                      adc #2
00000058: f1                      lb 
00000059: 23 f3                   xor 
0000005b: 10                      ldlp #0 [&var_0]
0000005c: 83                      adc #3
0000005d: f1                      lb 
0000005e: 23 f3                   xor 
00000060: 25 fa                   dup 
00000062: 10                      ldlp #0 [&var_0]
00000063: 23 fb                   sb 
00000065: 10                      ldlp #0 [&var_0]
00000066: 24 f2                   mint 
00000068: 41                      ldc #1
00000069: fb                      out 
0000006a: 64 0a                   j loc_26
0000006c: 00        loc_6c:       nop 
0000006d: b8                      ajw #8
0000006e: 22 f0                   ret 
