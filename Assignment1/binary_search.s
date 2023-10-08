.data
case1: .word 0x3DCCCCCD 0x41200000 0x3A83126F

case2: .word 0x42C80000 0x43800000 0x41200000

case3: .word 0x3F1020C5 0x3F800000 0x3C23D70A

linestr:  .string "\n"

resultstr: .string "The binary search result number is "

bfloatresultstr: .string "The target, upper bound and lower bound numbers are :"
spacestr: .string " "

splitlinestr: .string "-----------------\n"

.text
main:
    la s11, case1
    
    lw t1, 0(s11)
    jal ra, float32tobfloat16
    mv t3, t1
    
    lw t1, 4(s11)
    jal ra, float32tobfloat16
    mv t4, t1
    
    lw t1, 8(s11)
    jal ra, float32tobfloat16
    mv t5, t1
    
    jal ra, print_float
    jal ra, binary_search
    
    la s11, case2
    
    lw t1, 0(s11)
    jal ra, float32tobfloat16
    mv t3, t1
    
    lw t1, 4(s11)
    jal ra, float32tobfloat16
    mv t4, t1
    
    lw t1, 8(s11)
    jal ra, float32tobfloat16
    mv t5, t1
    
    jal ra, print_float
    jal ra, binary_search
    
    la s11, case3
    
    lw t1, 0(s11)
    jal ra, float32tobfloat16
    mv t3, t1
    
    lw t1, 4(s11)
    jal ra, float32tobfloat16
    mv t4, t1
    
    lw t1, 8(s11)
    jal ra, float32tobfloat16
    mv t5, t1

    jal ra, print_float
    jal ra, binary_search


    li  a7, 10        # end program
    ecall

float32tobfloat16:
    li s0, 0x7F800000 
    li s1, 0x007FFFFF 
    li s2, 0x00800000
    and a0, t1, s0 #a0 input exp 
    and a1, t1, s1 #a1 input man
    # or a1, a1, s2
    beq a0, x0, zerocheck
    beq a0, s0 print_float   
    
    jal s10 float32_div
    jal s10 float32_add
    
    li s0, 0xFFFF0000
    and t1, t2, s0
    ret
    
zerocheck:
    beq a1, x0, print_float
    
float32_div:
    li s0, 0xFF800000
    li s1, 0x04000000 #256
    # and s2, t1, s0 #pr=s2 input exp 
    sub a2, a0, s1 #a2 = a0 / 256
    jr s10

float32_add:
    li s0, 0x7F800000 
    li s1, 0x007FFFFF 
    li s2, 0x00800000
    and a3, a2, s0 #r exp
    and a4, a2, s1 #r man
    or a4, a4, s2
    sub a5, a0, a3 #a5 = shift
    srli a5, a5, 23
    srl a4, a4, a5 # shift r man
    
    add a6, a4, a1 #a6 res_man
    or t2, a0, a6
    jr s10

float_add:
    li s0, 0x7F800000 
    li s1, 0x007FFFFF 
    li s2, 0x00800000
    and a0, t4, s0 #a0 input exp 
    and a1, t4, s1 #a1 input man
    srli a0, a0, 23
    or a1, a1, s2
    
    and a3, t5, s0 #r exp
    and a4, t5, s1 #r man
    srli a3, a3, 23
    or a4, a4, s2
    
    sub a5, a0, a3 #a5 = shift
    srl a4, a4, a5 # shift r man
    
    add a6, a4, a1 #a6 res_man    
    li s7, 0x01000000
    and a7, a6, s7
    bne a7, x0, overflow
    
    and a6, a6,s1
    andi a0, a0, 0xff
    slli a0, a0, 23
    or t2, a0, a6
    jr s10
    

overflow:
    srli a6, a6 1
    addi a0, a0, 1
    and a6, a6,s1
    andi a0, a0, 0xff
    slli a0, a0, 23
    or t2, a0, a6
    jr s10


binary_search:

    # ub+lb
    jal s10 float_add #t2 output
    
    # div 2
    li s0, 0xFF800000
    li s1, 0x007FFFFF 
    li s2 0x01000000 #2
    and a0, t2, s0 #a0 t2 exp 
    and a1, t2, s1 #a0 t2 man 
    
    sub a2, a0, s1 #a2 = t2 / 2
    or a2, a2, a1
    li s0, 0xFFFF0000
    and a2, a2, s0
    
    add a0, t4, x0
    li  a7, 2        
    ecall
    
    la a0, spacestr
    li a7, 4
    ecall
    
    add a0, a2, x0
    li  a7, 2        
    ecall
    
    la a0, spacestr
    li a7, 4
    ecall
    
    add a0, t5, x0
    li  a7, 2        
    ecall
    
    la, a0, linestr
    li a7, 4
    ecall
    beq a2, t3 print_result
    blt t3, a2, mid_to_ub 
    blt a2, t3, mid_to_lb 
    
mid_to_lb:
    mv t5, a2
    j binary_search 
    
mid_to_ub: 
    mv t4, a2
    j binary_search 
   
print_float:
    la a0, bfloatresultstr
    li a7, 4
    ecall
    
    la, a0, linestr
    li a7, 4
    ecall
    
    add a0, t3, x0
    li  a7, 2        
    ecall
    
    la a0, spacestr
    li a7, 4
    ecall
    
    add a0, t4, x0
    li  a7, 2        
    ecall
    
    la a0, spacestr
    li a7, 4
    ecall
    
    add a0, t5, x0
    li  a7, 2        
    ecall
    
    la, a0, linestr
    li a7, 4
    ecall
    
    la, a0, splitlinestr
    li a7, 4
    ecall
    
    ret
    
    
   
print_result:
        
    la, a0, splitlinestr
    li a7, 4
    ecall
    
    la  a0, resultstr       # load string
    li  a7, 4         # print string
    ecall
    
    add a0, a2, x0    # load result
    li  a7, 2        # print integer
    ecall
    
    la, a0, linestr
    li a7, 4
    ecall
    ret               # go back to main