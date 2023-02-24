# 3-staged-pipelined-RISC-V_32I-Implementation
Coverted previous RISC-V-32I Single cycle implementation to 3 Staged Pipeline along with resolved hazards and CSR support.

# Pipelining:
The single cycle RISC-V processor is converted to a 3-stage pipeline processor to increase the throughput of processor. The three stages are as follows: 
1. Fetch
2. Decode-Execute
3. Memory-Write Back 

As a first step towards pipelining, flip-flops are inserted between these stages. Two flip-flops areinserted between stage 1 and stage 2 for storing the following: 
• Program Counter
• Instruction 

Similarly, flip-flops are inserted between stage2 and stage3 for retaining the following:
• Program Counter
• Instruction
• ALU Result
• Results of Forwarding Multiplexers
• Register Write Signal
• Write Back Signal
• CSR Read Write Signals
• MRET Signal 

# Resolving Hazards:
When implementing a pipeline processor, we have to handle the dependency between the instructions. These hazards can be of two types: 
• Data Hazards
• Control Hazards 

# Data Hazards:
# Forwarding:
In a 3-stage pipeline processor, some of the data hazards can be resolved by forwarding the ALU Result in Memory-Write Back stage to Decode-Execute stage using two forwarding multiplexers. Hence the result can be used prior to its writing back to register file.  In order to detect this data dependency a Forwarding Unit is used. Its input is the instruction and register write signal in the Memory-Write Back stage and the instruction in Decode-Execute stage.
 
 # Stalling:
 Forwarding is not sufficient in case of load instructions which can have multi-cycle latency due to which the results cannot be forwarded. The only solution left would be to stall the Program Counter until the result has been written to the register file. For this case, the operands of the Instruction in Fetch stage and the Instruction in Execute-Decode stage are compared.
 
 # Control Hazards:
 For taken branches as well as jumps the instruction which has been fetched should not be executed. That instruction should be flushed from the pipeline, while the program counter is updated to the new address. For this purpose, we need to flush the Decode-Execute stage which is done by setting the instruction pipeline register between the Fetch stage and the Decode-Execute to nop. Therefore, the forwarding unit is updated and br_res is given it as input and the flush signal is the output. 
 
 # CSR Support:
 In order to support privileged architecture in our pipelined processor, we are going to partially support the machine mode of the RISC-V specification in our processor. This will involve adding support for some new instructions in our data path. We are also going to create a new register file which is going to contain the machine mode CSR registers which can be accessed by these new instructions. We will be supporting only two instructions: 
• CSSRW
• MRET 

In order to support this instruction machine mode registers will be added to the CSR Register file,
which are as follows: 
• MCAUSE
• MSTATUS
• MTVEC
• MEPC
• MIP 
• MIE 

With the help of CSRRW, we will be able to read and write the above registers. Reading of registers is done combinationally and the writing of registers is done sequentially. The controller is also updated in order to decode these instructions. The 12 bits of instruction in Memory-Write Back stage are used as address for the CSR Register File. The Program Counter in the MemoryWrite Back stage is also an input to the CSR unit which is necessary for MRET instruction.

# Handling Interrupt:
In order to handle the interrupt some more support is added in the CSR module. The support is added only for handling timer interrupt. Also, we are working only in direct-mode and there is no need for an encoder as we are only handling a single interrupt. 

Whenever an interrupt arrives, the corresponding bit in the MIP and MCAUSE register gets high. The corresponding bits of MSTATUS and MIE register are checked so as to see if the interrupt has been enabled or not. If the interrupt is enabled and the interrupt has arrived, the following steps are executed. 

• MEPC stores the value of PC at Memory-Write Back stage.
• EPC stores the base address of vector table stored in MTVEC.
• CSR flag goes high to tell Program counter to jump to EPC and start handling the interrupt.
• CSR Flush signal goes high to flush the fetched instruction. 

After the interrupt is handled successfully, we need to resume the usual execution of instructions. Therefore, MRET instruction is executed. In this instruction, EPC gets updated to the value stored in MEPC when the interrupt arrived and the CSR Flag gets high. In this way Program Counter jumps back to the usual execution of instructions. 
