// in basic.s
main:
	addi x2, x0, 9
	addi x3, x0, 2
    bne x2, x3, imm
rtype:
	add x4, x2, x3
	sub x5, x2, x3
	sll x6, x2, x3
	sltu x7, x2, x3
	xor x8, x2, x3
	srl x9, x2, x3
	sra x10, x2, x3
	or x11, x2, x3
	and x12, x2, x3
    bge x2, x3, load
imm:
	addi x13, x2, 3
	slli x14, x2, 3
	xori x15, x2, 3
	srli x16, x2, 3
	srai x17, x2, 3
	ori x18, x2, 3
	andi x19, x2, 3
    j rtype
load:
	lw x20, 0x04(x0)
	lb x21, 0x04(x0)
	lh x22, 0x04(x0)
    j upper_imm
store:
	sw x20, 0x14(x0)
	sb x20, 0x18(x0)
	sh x20, 0x1c(x0)
    j end
upper_imm:
	lui x25, 0x12345
	addi x25, x25, 0x678
	lui x26, 0x12346
	addi x26, x26,0xFFFFFA78
	auipc x27, 0x23456
    bgeu x2, x3, store
end:
	j end