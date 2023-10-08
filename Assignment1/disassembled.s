00000000 <main>:
    0:        10000d97        auipc x27 0x10000
    4:        000d8d93        addi x27 x27 0
    8:        000da303        lw x6 0 x27
    c:        098000ef        jal x1 152 <float32tobfloat16>
    10:        00030e13        addi x28 x6 0
    14:        004da303        lw x6 4 x27
    18:        08c000ef        jal x1 140 <float32tobfloat16>
    1c:        00030e93        addi x29 x6 0
    20:        008da303        lw x6 8 x27
    24:        080000ef        jal x1 128 <float32tobfloat16>
    28:        00030f13        addi x30 x6 0
    2c:        208000ef        jal x1 520 <print_float>
    30:        168000ef        jal x1 360 <binary_search>
    34:        10000d97        auipc x27 0x10000
    38:        fd8d8d93        addi x27 x27 -40
    3c:        000da303        lw x6 0 x27
    40:        064000ef        jal x1 100 <float32tobfloat16>
    44:        00030e13        addi x28 x6 0
    48:        004da303        lw x6 4 x27
    4c:        058000ef        jal x1 88 <float32tobfloat16>
    50:        00030e93        addi x29 x6 0
    54:        008da303        lw x6 8 x27
    58:        04c000ef        jal x1 76 <float32tobfloat16>
    5c:        00030f13        addi x30 x6 0
    60:        1d4000ef        jal x1 468 <print_float>
    64:        134000ef        jal x1 308 <binary_search>
    68:        10000d97        auipc x27 0x10000
    6c:        fb0d8d93        addi x27 x27 -80
    70:        000da303        lw x6 0 x27
    74:        030000ef        jal x1 48 <float32tobfloat16>
    78:        00030e13        addi x28 x6 0
    7c:        004da303        lw x6 4 x27
    80:        024000ef        jal x1 36 <float32tobfloat16>
    84:        00030e93        addi x29 x6 0
    88:        008da303        lw x6 8 x27
    8c:        018000ef        jal x1 24 <float32tobfloat16>
    90:        00030f13        addi x30 x6 0
    94:        1a0000ef        jal x1 416 <print_float>
    98:        100000ef        jal x1 256 <binary_search>
    9c:        00a00893        addi x17 x0 10
    a0:        00000073        ecall

000000a4 <float32tobfloat16>:
    a4:        7f800437        lui x8 0x7f800
    a8:        008004b7        lui x9 0x800
    ac:        fff48493        addi x9 x9 -1
    b0:        00800937        lui x18 0x800
    b4:        00837533        and x10 x6 x8
    b8:        009375b3        and x11 x6 x9
    bc:        00050e63        beq x10 x0 28 <zerocheck>
    c0:        16850a63        beq x10 x8 372 <print_float>
    c4:        01800d6f        jal x26 24 <float32_div>
    c8:        02400d6f        jal x26 36 <float32_add>
    cc:        ffff0437        lui x8 0xffff0
    d0:        0083f333        and x6 x7 x8
    d4:        00008067        jalr x0 x1 0

000000d8 <zerocheck>:
    d8:        14058e63        beq x11 x0 348 <print_float>

000000dc <float32_div>:
    dc:        ff800437        lui x8 0xff800
    e0:        040004b7        lui x9 0x4000
    e4:        40950633        sub x12 x10 x9
    e8:        000d0067        jalr x0 x26 0

000000ec <float32_add>:
    ec:        7f800437        lui x8 0x7f800
    f0:        008004b7        lui x9 0x800
    f4:        fff48493        addi x9 x9 -1
    f8:        00800937        lui x18 0x800
    fc:        008676b3        and x13 x12 x8
    100:        00967733        and x14 x12 x9
    104:        01276733        or x14 x14 x18
    108:        40d507b3        sub x15 x10 x13
    10c:        0177d793        srli x15 x15 23
    110:        00f75733        srl x14 x14 x15
    114:        00b70833        add x16 x14 x11
    118:        010563b3        or x7 x10 x16
    11c:        000d0067        jalr x0 x26 0

00000120 <float_add>:
    120:        7f800437        lui x8 0x7f800
    124:        008004b7        lui x9 0x800
    128:        fff48493        addi x9 x9 -1
    12c:        00800937        lui x18 0x800
    130:        008ef533        and x10 x29 x8
    134:        009ef5b3        and x11 x29 x9
    138:        01755513        srli x10 x10 23
    13c:        0125e5b3        or x11 x11 x18
    140:        008f76b3        and x13 x30 x8
    144:        009f7733        and x14 x30 x9
    148:        0176d693        srli x13 x13 23
    14c:        01276733        or x14 x14 x18
    150:        40d507b3        sub x15 x10 x13
    154:        00f75733        srl x14 x14 x15
    158:        00b70833        add x16 x14 x11
    15c:        01000bb7        lui x23 0x1000
    160:        017878b3        and x17 x16 x23
    164:        00089c63        bne x17 x0 24 <overflow>
    168:        00987833        and x16 x16 x9
    16c:        0ff57513        andi x10 x10 255
    170:        01751513        slli x10 x10 23
    174:        010563b3        or x7 x10 x16
    178:        000d0067        jalr x0 x26 0

0000017c <overflow>:
    17c:        00185813        srli x16 x16 1
    180:        00150513        addi x10 x10 1
    184:        00987833        and x16 x16 x9
    188:        0ff57513        andi x10 x10 255
    18c:        01751513        slli x10 x10 23
    190:        010563b3        or x7 x10 x16
    194:        000d0067        jalr x0 x26 0

00000198 <binary_search>:
    198:        f89ffd6f        jal x26 -120 <float_add>
    19c:        ff800437        lui x8 0xff800
    1a0:        008004b7        lui x9 0x800
    1a4:        fff48493        addi x9 x9 -1
    1a8:        01000937        lui x18 0x1000
    1ac:        0083f533        and x10 x7 x8
    1b0:        0093f5b3        and x11 x7 x9
    1b4:        40950633        sub x12 x10 x9
    1b8:        00b66633        or x12 x12 x11
    1bc:        ffff0437        lui x8 0xffff0
    1c0:        00867633        and x12 x12 x8
    1c4:        000e8533        add x10 x29 x0
    1c8:        00200893        addi x17 x0 2
    1cc:        00000073        ecall
    1d0:        10000517        auipc x10 0x10000
    1d4:        eb050513        addi x10 x10 -336
    1d8:        00400893        addi x17 x0 4
    1dc:        00000073        ecall
    1e0:        00060533        add x10 x12 x0
    1e4:        00200893        addi x17 x0 2
    1e8:        00000073        ecall
    1ec:        10000517        auipc x10 0x10000
    1f0:        e9450513        addi x10 x10 -364
    1f4:        00400893        addi x17 x0 4
    1f8:        00000073        ecall
    1fc:        000f0533        add x10 x30 x0
    200:        00200893        addi x17 x0 2
    204:        00000073        ecall
    208:        10000517        auipc x10 0x10000
    20c:        e1c50513        addi x10 x10 -484
    210:        00400893        addi x17 x0 4
    214:        00000073        ecall
    218:        0bc60263        beq x12 x28 164 <print_result>
    21c:        00ce4863        blt x28 x12 16 <mid_to_ub>
    220:        01c64263        blt x12 x28 4 <mid_to_lb>

00000224 <mid_to_lb>:
    224:        00060f13        addi x30 x12 0
    228:        f71ff06f        jal x0 -144 <binary_search>

0000022c <mid_to_ub>:
    22c:        00060e93        addi x29 x12 0
    230:        f69ff06f        jal x0 -152 <binary_search>

00000234 <print_float>:
    234:        10000517        auipc x10 0x10000
    238:        e1650513        addi x10 x10 -490
    23c:        00400893        addi x17 x0 4
    240:        00000073        ecall
    244:        10000517        auipc x10 0x10000
    248:        de050513        addi x10 x10 -544
    24c:        00400893        addi x17 x0 4
    250:        00000073        ecall
    254:        000e0533        add x10 x28 x0
    258:        00200893        addi x17 x0 2
    25c:        00000073        ecall
    260:        10000517        auipc x10 0x10000
    264:        e2050513        addi x10 x10 -480
    268:        00400893        addi x17 x0 4
    26c:        00000073        ecall
    270:        000e8533        add x10 x29 x0
    274:        00200893        addi x17 x0 2
    278:        00000073        ecall
    27c:        10000517        auipc x10 0x10000
    280:        e0450513        addi x10 x10 -508
    284:        00400893        addi x17 x0 4
    288:        00000073        ecall
    28c:        000f0533        add x10 x30 x0
    290:        00200893        addi x17 x0 2
    294:        00000073        ecall
    298:        10000517        auipc x10 0x10000
    29c:        d8c50513        addi x10 x10 -628
    2a0:        00400893        addi x17 x0 4
    2a4:        00000073        ecall
    2a8:        10000517        auipc x10 0x10000
    2ac:        dda50513        addi x10 x10 -550
    2b0:        00400893        addi x17 x0 4
    2b4:        00000073        ecall
    2b8:        00008067        jalr x0 x1 0

000002bc <print_result>:
    2bc:        10000517        auipc x10 0x10000
    2c0:        dc650513        addi x10 x10 -570
    2c4:        00400893        addi x17 x0 4
    2c8:        00000073        ecall
    2cc:        10000517        auipc x10 0x10000
    2d0:        d5a50513        addi x10 x10 -678
    2d4:        00400893        addi x17 x0 4
    2d8:        00000073        ecall
    2dc:        00060533        add x10 x12 x0
    2e0:        00200893        addi x17 x0 2
    2e4:        00000073        ecall
    2e8:        10000517        auipc x10 0x10000
    2ec:        d3c50513        addi x10 x10 -708
    2f0:        00400893        addi x17 x0 4
    2f4:        00000073        ecall
    2f8:        00008067        jalr x0 x1 0

