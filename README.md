# 3-staged-pipelined-RISC-V_32I-Implementation
Coverted previous RISC-V-32I Single cycle implementation to 3 Staged Pipeline along with resolved hazards and CSR support.

# Pipeline Implementation: 
The single cycle RISC-V 32I is converted to a 3-staged pipeline. Following are the 3 stages: 
* Fetch
* Decode & Execute
* Memory & write back 

The pipelining is done to increase the throughput of the processor, but the time of completion remains same. Pipelining is instantiated by including 2 new modules that contains the required Flip Flops that act as pipeline registers. For the first module “Fetch to Decode-Execute” Flip flops for following:
* PC -> PC_DE
* Instruction -> Instruction_DE

Where, PC is coming from program counter and instruction from instruction memory. For the second module, following flip flops are inserted:
* PC_DE -> PC_MW
* Instruction_DE -> Instruction_MW
* Alu_result -> Alu_result_MW
* rdata2 -> rdata2_MW
* wdata_sel -> wdata_sel_MW
* rfwrite -> rfwrite_MW

Where, Alu_result is the output signal of ALU, rdata2 is second output of register file, wdata_sel and rfwrite are signals coming from controller. 
