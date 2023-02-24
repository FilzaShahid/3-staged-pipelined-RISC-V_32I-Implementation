// in codecsr.s
li x2, 8   
li x3, 128 
li x4, 28  

csrrw x0, mstatus, x2 
csrrw x0, mie, x3
csrrw x0, mtvec, x4    

jal x12,  main    
jal x13, handler  

main:
    addi x6, x6, 1 
    addi x7, x7, 2 
stop:
    addi x9, x9, 1
    addi x10, x10, 2  
    jal x14, stop  

handler:
    csrrw x0,mie,x0   
    xori x16, x16, 0xFFFFFFFF 
    addi x17, x17, 10
    csrrw x0,mie, x3  
    mret   
    nop  
    nop   
    nop   
