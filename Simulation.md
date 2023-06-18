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


### Simulation:


### Register Memory:


### Data Memory:

### Instruction Memory:


## Case 2:
### Assembly Instructions:


### Simulation:


### Register Memory:


### Data Memory:


### Instruction Memory:
