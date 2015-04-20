
; New subroutine 0+9; References: 0, Local Vars: 3
00000000: 60 bd     sub_0:        ajw #-3
00000002: 24 f2                   mint 
00000004: 24 20 50                ldnlp #400
00000007: 23 fc                   gajw 

; New subroutine 9+1b; References: 0, Local Vars: 3
00000009: 60 bd     sub_9:        ajw #-3
0000000b: 10                      ldlp #0 [&var_0]
0000000c: 24 f2                   mint 
0000000e: 54                      ldnlp #4
0000000f: 4c                      ldc #c
00000010: f7                      in 
00000011: 4b                      ldc #b
00000012: 21 fb                   ldpi [loc_1f]
00000014: 24 f2                   mint 
00000016: 54                      ldnlp #4
00000017: 70                      ldl #0 [var_0]
00000018: f7                      in 
00000019: 43                      ldc #3
0000001a: 21 fb                   ldpi [loc_1f]
0000001c: 72                      ldl #2 [var_2]
0000001d: f2                      bsub 
0000001e: f6                      gcall 
0000001f: 00        loc_1f:       nop 
00000020: b3                      ajw #3
00000021: 22 f0                   ret 
00000023: 20                      .db #20 ' '
