
; New subroutine 0+6; References: 1, Local Vars: 0
;	Called/referenced from 1b
00000000: 73     sub_0:        ldl #3 [arg_3]
00000001: 72                   ldl #2 [arg_2]
00000002: 74                   ldl #4 [arg_4]
00000003: f7                   in 
00000004: 22 f0                ret 

; New subroutine 6+6; References: 1, Local Vars: 0
;	Called/referenced from 3c
00000006: 73     sub_6:        ldl #3 [arg_3]
00000007: 72                   ldl #2 [arg_2]
00000008: 74                   ldl #4 [arg_4]
00000009: fb                   out 
0000000a: 22 f0                ret 

; New subroutine c+38; References: 0, Local Vars: 5
0000000c: 60 bb  sub_c:        ajw #-5
0000000e: 40                   ldc #0
0000000f: d1                   stl #1 [var_1]
00000010: 40                   ldc #0
00000011: 11                   ldlp #1 [&var_1]
00000012: 23 fb                sb 
00000014: 4c     loc_14:       ldc #c
00000015: d0                   stl #0 [var_0]
00000016: 12                   ldlp #2 [&var_2]
00000017: 24 f2                mint 
00000019: 54                   ldnlp #4
0000001a: 76                   ldl #6 [arg_1]
0000001b: 61 93                call sub_0
0000001d: 40                   ldc #0
0000001e: d0                   stl #0 [var_0]
0000001f: 70     loc_1f:       ldl #0 [var_0]
00000020: 12                   ldlp #2 [&var_2]
00000021: f2                   bsub 
00000022: f1                   lb 
00000023: 11                   ldlp #1 [&var_1]
00000024: f1                   lb 
00000025: f2                   bsub 
00000026: 2f 4f                ldc #ff
00000028: 24 f6                and 
0000002a: 11                   ldlp #1 [&var_1]
0000002b: 23 fb                sb 
0000002d: 70                   ldl #0 [var_0]
0000002e: 81                   adc #1
0000002f: d0                   stl #0 [var_0]
00000030: 4c                   ldc #c
00000031: 70                   ldl #0 [var_0]
00000032: f9                   gt 
00000033: a2                   cj loc_36
00000034: 61 09                j loc_1f
00000036: 41     loc_36:       ldc #1
00000037: d0                   stl #0 [var_0]
00000038: 11                   ldlp #1 [&var_1]
00000039: 24 f2                mint 
0000003b: 76                   ldl #6 [arg_1]
0000003c: 63 98                call sub_6
0000003e: 20                   .db #20 ' '
0000003f: 62 03                j loc_14
00000041: 20                   .db #20 ' '
00000042: 20                   .db #20 ' '
00000043: 20                   .db #20 ' '
