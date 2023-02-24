/*----------------------------------------------------------------
  Module for Datapath
------------------------------------------------------------------*/
module Datapath
	(
		input logic clk, reset, rfwrite, Use_Imm, csr_reg_rd, csr_reg_wr, is_mret,
		input logic[2:0] Extend_sel, br_type, 
		input logic[1:0] sel_PC, wdata_sel,
		input logic[3:0] ALUop, 
		output logic[2:0] func3, 
		output logic[6:0] func7, opcode
	);

logic br_taken, rfwrite_MW, For_A, For_B, Flush, Stall, csr_reg_rd_MW, csr_reg_wr_MW, intr_expc, control, 
	  flush_interrupt, is_mret_MW;
logic [1:0] wdata_sel_MW;
logic [3:0] mask;
logic [4:0] radd1, radd2, wadd, SLImm;
logic [11:0] Imm, SImm;
logic [12:0] BImm;
logic [19:0] UImm;
logic [20:0] JImm;
logic [31:0] rdata1, rdata2, wdata, PC, Instruction, Extended_Imm, Imm_out, Alu_result, Mem_outData, rs1_out, 
			LSU_wdata, PC_DE, Instruction_DE, Alu_result_MW, PC_MW, Instruction_MW, rdata2_MW, Forwarded_rdata1,
			Forwarded_rdata2, rdata1_MW, epc, csr_rdata;


// Single Cycle Implementation

Program_Counter Prog_C (clk, reset, br_taken, Stall, control, Alu_result, epc, PC);

Instruction_Memory Inst (PC, Instruction);

Decoder decode (Instruction_DE, radd1, radd2, wadd, SLImm, func3, func7, opcode, Imm, SImm, BImm, UImm, JImm);

Register Reg (clk, rfwrite_MW, radd1, radd2, Instruction_MW[11:7], wdata, rdata1, rdata2);

Sign_Extender Extend(Extend_sel, Imm, SImm, SLImm, UImm, BImm, JImm, Extended_Imm);

Mux3x1 Mux_rs1(sel_PC, Forwarded_rdata1, PC_DE, 32'b0, rs1_out);

Mux2x1 Mux_Imm(Use_Imm, Forwarded_rdata2, Extended_Imm, Imm_out);

Mux4x1 Mux_mem(wdata_sel_MW, Alu_result_MW, LSU_wdata, PC_MW + 32'd4, csr_rdata, wdata);

Data_Memory Data(clk, cs, rd_wr, mask, Alu_result_MW, rdata2_MW, Mem_outData);

Load_Store_Unit LSU(Instruction_MW[14:12], Instruction_MW[6:0], Mem_outData, Alu_result_MW, cs, 
					rd_wr, mask, LSU_wdata);

ALU ALU_opr (rs1_out, Imm_out, ALUop, Alu_result);

Branch_Comparator Comparison(rdata1, rdata2, br_type, br_taken);

// Introducing 3 stage Pipelining

F_to_DE fe_to_dec_exec (clk, reset, Flush, flush_interrupt, PC, Instruction, PC_DE, Instruction_DE);

DE_to_MW dec_exec_to_mem_wr (clk, reset, rfwrite, csr_reg_rd, csr_reg_wr, is_mret, wdata_sel, PC_DE, Alu_result, 
							Forwarded_rdata2, Forwarded_rdata1, Instruction_DE, rfwrite_MW, csr_reg_rd_MW, csr_reg_wr_MW,
							is_mret_MW, wdata_sel_MW, PC_MW, Alu_result_MW, rdata2_MW, rdata1_MW, Instruction_MW);

// Implementing Forwarding 

Forwarding_Unit For_Unit (Instruction, Instruction_DE, Instruction_MW, rfwrite_MW, br_taken, 
						 For_A, For_B, Stall, Flush);

Mux2x1 Forward_rs1 (For_A, rdata1, Alu_result_MW, Forwarded_rdata1);

Mux2x1 Forward_rs2 (For_B, rdata2, Alu_result_MW, Forwarded_rdata2);

// Adding CSR functioning

CSR_RegFile CSR(clk, reset, intr_expc, csr_reg_wr_MW, csr_reg_rd_MW, is_mret_MW, Instruction_MW[31:20], PC_MW, rdata1_MW, 
				control, flush_interrupt, csr_rdata, epc);

// Adding timer interrupt
timer timer_interrupt(clk, reset, intr_expc);

endmodule