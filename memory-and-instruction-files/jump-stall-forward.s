// in jump,stall,forward.s
	addi x7, x0, 3
	addi x8, x7, 25
	sw x8, 0x0c(x0)
	lw x9, 0x0c(x0)
	add x10, x9, x8
main:
	addi x1, x0, 2
	addi x2, x1, 3
	bne x2, x1, jump
back:
	sw x4, 0x08(x0)
	lw x5, 0x08(x0)
    sub x6, x5, x2
    bge x5, x1, stop
jump:
	sw x2, 0x04(x0)
    lw x3, 0x04(x0)
    add x4, x3, x2
    j back
stop:
	j stop