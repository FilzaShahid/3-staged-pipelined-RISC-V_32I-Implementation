# Testing and Simulation
## Case 1: GCD computation
### Assembly Instructions:

    li x8, 56
    li x9, 84
    gcd:
        beq x8, x9, stop
        blt x8, x9, less
        sub x8, x8, x9
        j gcd
    less:
        sub x9, x9, x8
        j gcd
    stop:
        sw x8, 0x08(x0)
        lw x10, 0x08(x0)

### Machine Code

    03800413
    05400493
    00940c63
    00944663
    40940433
    ff5ff06f
    408484b3
    fedff06f
    00802423
    00802503
    0000006f

### Simulation:

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/7c3096a1-934a-4596-8050-5bef8f877462)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/144112d4-1159-47ff-ba59-82cae3948227)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/8502a2c2-d130-47de-a046-b39618e05885)

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/1d336a15-7db3-497f-b59d-ca57e5f7c26a)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/7568a41d-1719-4d1b-aea3-2fbc55ab343b)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/63b4fbbe-2771-4d5d-b8da-5cff2853e9b6)

### Register Memory:

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/b085d0f9-469a-453a-a6bd-091fcabdf545)

### Data Memory:

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/be593ac6-7679-4783-8bc4-b77b317848d4)

### Instruction Memory:

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/5289c4be-f7ea-4e1a-b9f5-298baabee4e9)

## Case 2: Stalling, Forwarding and Flushing
### Assembly Instructions:

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

### Machine Code:

    00300393
    01938413
    00802623
    00c02483
    00848533
    00200093
    00308113
    00111a63
    00402423
    00802283
    40228333
    0012da63
    00202223
    00402183
    00218233
    fe5ff06f
    0000006f

### Simulation:

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/58d4a323-56be-4220-a5c2-4ff574054456)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/c4a97be4-8b7f-4a78-b5c8-b1111ccc67fa)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/2c42395f-24d5-4bbe-a9b5-f3e904214f99)

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/df0a9e47-9520-415c-9d60-bc8807c75baf)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/46eb10e3-5df6-4e25-9bb1-71b482c9c455)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/82deebc4-6b88-405b-8930-8c1b6970092c)

### Register Memory:

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/3f804151-2105-40a3-8d72-26b5deea27d2)

### Data Memory:

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/161a5456-7ea6-4d49-b24a-0f4d48e7c189)

### Instruction Memory:
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/f267ae0a-4138-4199-80b3-a6da9268b48b)

## Case 3: CSR Timer Interrupt Handler
### Assembly Instructions:
        
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

### Machine Code:

    00800113
    08000193
    01c00213
    30011073
    30419073
    30521073
    0080066f
    018006ef
    00130313
    00238393
    00148493
    00250513
    ff9ff76f
    30401073
    fff84813
    00a88893
    30419073
    30200073
    00000013
    00000013
    00000013

### Simulation:

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/09dae515-7d5d-461e-bd53-3c1165969083)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/08d4a974-c768-4833-950b-de0894c0c13d)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/83085a36-ffc7-4dad-b28e-4a1b7bca4d29)

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/3288c3be-0ec2-4e4e-a133-a3e693a15909)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/6d10429c-9366-4890-9873-7058b2c26a9c)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/4770511d-7d59-497b-a96d-ab886638b7e5)

![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/ad318373-35d7-4ee8-94a7-ac14a97fd24e)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/7b66000b-6b1d-4a97-a0f1-32dd715e2404)
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/8b23150f-3a9c-4eb1-b014-06efd3c7a4f6)

### Register Memory:

When interrupt occurs first time, register memory (handler executed) is as follows:-
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/5e36672c-ac05-40af-af99-6594c4d38efb)

When interrupt occurs second time, register memory (handler executed) is as follows:-
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/3df55d78-d205-42eb-9744-f13ff7dc5cf4)

### Instruction Memory:
![image](https://github.com/FilzaShahid/3-staged-pipelined-RISC-V_32I-Implementation/assets/58341924/8dd7bfd7-6d50-44a6-baee-acc13f610a29)
