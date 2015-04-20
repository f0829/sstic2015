
; New subroutine 0+d; References: 0, Local Vars: 76
00000000: 64 b4     sub_0:        ajw #-4c
00000002: 40                      ldc #0
00000003: d1                      stl #1 [var_1]
00000004: 40                      ldc #0
00000005: d3                      stl #3 [var_3]
00000006: 24 f2                   mint 
00000008: 24 20 50                ldnlp #400
0000000b: 23 fc                   gajw 

; New subroutine d+eb; References: 0, Local Vars: 76
0000000d: 64 b4     sub_d:        ajw #-4c
0000000f: 2c 49                   ldc #c9
00000011: 21 fb                   ldpi [str_dc]
00000013: 24 f2                   mint 
00000015: 48                      ldc #8
00000016: fb                      out 
00000017: 24 19     loc_17:       ldlp #49 [&var_73]
00000019: 24 f2                   mint 
0000001b: 54                      ldnlp #4
0000001c: 4c                      ldc #c
0000001d: f7                      in 
0000001e: 24 79                   ldl #49 [var_73]
00000020: 21 a5                   cj loc_37
00000022: 2c 4d                   ldc #cd
00000024: 21 fb                   ldpi [loc_f3]
00000026: 24 f2                   mint 
00000028: 54                      ldnlp #4
00000029: 24 79                   ldl #49 [var_73]
0000002b: f7                      in 
0000002c: 2c 43                   ldc #c3
0000002e: 21 fb                   ldpi [loc_f3]
00000030: 24 7a                   ldl #4a [var_74]
00000032: 24 79                   ldl #49 [var_73]
00000034: fb                      out 
00000035: 61 00                   j loc_17
00000037: 24 19     loc_37:       ldlp #49 [&var_73]
00000039: 24 f2                   mint 
0000003b: 51                      ldnlp #1
0000003c: 4c                      ldc #c
0000003d: fb                      out 
0000003e: 24 19                   ldlp #49 [&var_73]
00000040: 24 f2                   mint 
00000042: 52                      ldnlp #2
00000043: 4c                      ldc #c
00000044: fb                      out 
00000045: 24 19                   ldlp #49 [&var_73]
00000047: 24 f2                   mint 
00000049: 53                      ldnlp #3
0000004a: 4c                      ldc #c
0000004b: fb                      out 
0000004c: 29 44                   ldc #94
0000004e: 21 fb                   ldpi [str_e4]
00000050: 24 f2                   mint 
00000052: 48                      ldc #8
00000053: fb                      out 
00000054: 12                      ldlp #2 [&var_2]
00000055: 24 f2                   mint 
00000057: 54                      ldnlp #4
00000058: 44                      ldc #4
00000059: f7                      in 
0000005a: 15                      ldlp #5 [&var_5]
0000005b: 24 f2                   mint 
0000005d: 54                      ldnlp #4
0000005e: 4c                      ldc #c
0000005f: f7                      in 
00000060: 28 48                   ldc #88
00000062: 21 fb                   ldpi [str_ec]
00000064: 24 f2                   mint 
00000066: 48                      ldc #8
00000067: fb                      out 
00000068: 13                      ldlp #3 [&var_3]
00000069: 24 f2                   mint 
0000006b: 54                      ldnlp #4
0000006c: 41                      ldc #1
0000006d: f7                      in 
0000006e: 19                      ldlp #9 [&var_9]
0000006f: 24 f2                   mint 
00000071: 54                      ldnlp #4
00000072: 13                      ldlp #3 [&var_3]
00000073: f1                      lb 
00000074: f7                      in 
00000075: 40                      ldc #0
00000076: d4                      stl #4 [var_4]
00000077: 11        loc_77:       ldlp #1 [&var_1]
00000078: 24 f2                   mint 
0000007a: 54                      ldnlp #4
0000007b: 41                      ldc #1
0000007c: f7                      in 
0000007d: 15                      ldlp #5 [&var_5]
0000007e: 24 f2                   mint 
00000080: 51                      ldnlp #1
00000081: 4c                      ldc #c
00000082: fb                      out 
00000083: 15                      ldlp #5 [&var_5]
00000084: 24 f2                   mint 
00000086: 52                      ldnlp #2
00000087: 4c                      ldc #c
00000088: fb                      out 
00000089: 15                      ldlp #5 [&var_5]
0000008a: 24 f2                   mint 
0000008c: 53                      ldnlp #3
0000008d: 4c                      ldc #c
0000008e: fb                      out 
0000008f: 10                      ldlp #0 [&var_0]
00000090: 81                      adc #1
00000091: 24 f2                   mint 
00000093: 55                      ldnlp #5
00000094: 41                      ldc #1
00000095: f7                      in 
00000096: 10                      ldlp #0 [&var_0]
00000097: 82                      adc #2
00000098: 24 f2                   mint 
0000009a: 56                      ldnlp #6
0000009b: 41                      ldc #1
0000009c: f7                      in 
0000009d: 10                      ldlp #0 [&var_0]
0000009e: 83                      adc #3
0000009f: 24 f2                   mint 
000000a1: 57                      ldnlp #7
000000a2: 41                      ldc #1
000000a3: f7                      in 
000000a4: 10                      ldlp #0 [&var_0]
000000a5: 81                      adc #1
000000a6: f1                      lb 
000000a7: 10                      ldlp #0 [&var_0]
000000a8: 82                      adc #2
000000a9: f1                      lb 
000000aa: 23 f3                   xor 
000000ac: 10                      ldlp #0 [&var_0]
000000ad: 83                      adc #3
000000ae: f1                      lb 
000000af: 23 f3                   xor 
000000b1: 10                      ldlp #0 [&var_0]
000000b2: 81                      adc #1
000000b3: 23 fb                   sb 
000000b5: 11                      ldlp #1 [&var_1]
000000b6: f1                      lb 
000000b7: 74                      ldl #4 [var_4]
000000b8: 15                      ldlp #5 [&var_5]
000000b9: f2                      bsub 
000000ba: f1                      lb 
000000bb: 74                      ldl #4 [var_4]
000000bc: 2c f1                   ssub 
000000be: 23 f3                   xor 
000000c0: 10                      ldlp #0 [&var_0]
000000c1: 23 fb                   sb 
000000c3: 10                      ldlp #0 [&var_0]
000000c4: 81                      adc #1
000000c5: f1                      lb 
000000c6: 74                      ldl #4 [var_4]
000000c7: 15                      ldlp #5 [&var_5]
000000c8: f2                      bsub 
000000c9: 23 fb                   sb 
000000cb: 74                      ldl #4 [var_4]
000000cc: 81                      adc #1
000000cd: 25 fa                   dup 
000000cf: d4                      stl #4 [var_4]
000000d0: cc                      eqc #c
000000d1: a3                      cj loc_d5
000000d2: 80                      adc #0
000000d3: 40                      ldc #0
000000d4: d4                      stl #4 [var_4]
000000d5: 10        loc_d5:       ldlp #0 [&var_0]
000000d6: 24 f2                   mint 
000000d8: 41                      ldc #1
000000d9: fb                      out 
000000da: 66 0b                   j loc_77
000000dc: **        str_dc:      .string "Boot ok"
000000e4: **        str_e4:      .string "Code Ok"
000000ec: **        str_ec:      .string "Decrypt"
000000f4: 24 bc                   ajw #4c
000000f6: 22 f0                   ret 
