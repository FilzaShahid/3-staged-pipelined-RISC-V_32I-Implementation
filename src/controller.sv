/*----------------------------------------------------------------
  Module for Controller
------------------------------------------------------------------*/
module Controller
	(
		input logic[2:0] func3, 
		input logic[6:0] opcode, func7, 
		output logic rfwrite, Use_Imm, csr_reg_rd, csr_reg_wr, is_mret,
		output logic[2:0] Extend_sel, br_type, 
		output logic[1:0] sel_PC, wdata_sel, 
		output logic[3:0] ALUop
	);

always_comb begin                                                                                                                                                                                                  
	//Generating Signals for overall Datapath
	case(opcode)
		7'b0110011: begin    // R Type Instruction
						rfwrite   = 1;
						Use_Imm   = 0;
						Extend_sel = 0;
						wdata_sel = 0;
						ALUop = 0;
						sel_PC = 0;
						br_type = 0;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
					end
		7'b0010011: begin    // I Type Instruction
						Use_Imm   = 1; 
						rfwrite   = 1;
						Extend_sel = 0;
						wdata_sel = 0;
						ALUop = 0;
						sel_PC = 0;
						br_type = 0;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
					end
		7'b0000011: begin    //Load Instruction
						Use_Imm   = 1; 
						rfwrite   = 1;
						Extend_sel = 0;
						wdata_sel = 1;
						ALUop = 0;
						sel_PC = 0; 
						br_type = 0;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
					end
		7'b0100011: begin    //Store Instruction
						Use_Imm   = 1; 
						rfwrite   = 0;
						Extend_sel = 1;
						wdata_sel = 0;
						ALUop = 0;
						sel_PC = 0;
						br_type = 0;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
					end
		7'b0110111: begin    // LUI Instruction
						rfwrite   = 1;
						Use_Imm   = 1;
						Extend_sel = 3;
						wdata_sel = 0;
						ALUop = 0;
						sel_PC = 2;
						br_type = 0;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
					end
		7'b0010111: begin    // AUIPC Type Instruction
						rfwrite   = 1;
						Use_Imm   = 1;
						Extend_sel = 3;
						wdata_sel = 0;
						ALUop = 0;
						sel_PC = 1;
						br_type = 0;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
					end
		7'b1100011: begin    // B Type Instruction
						rfwrite   = 0;
						Use_Imm   = 1;
						Extend_sel = 4;
						wdata_sel = 0;
						ALUop = 0;
						sel_PC = 1;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
						case(func3)
							3'b000 : br_type = 3'b001;
							3'b001 : br_type = 3'b010;
							3'b100 : br_type = 3'b011;
							3'b101 : br_type = 3'b100;
							3'b110 : br_type = 3'b101;
							3'b111 : br_type = 3'b110;
							default: br_type = 3'b000;
						endcase
					end
		7'b1101111: begin    // JAL Type Instruction
						rfwrite   = 1;
						Use_Imm   = 1;
						Extend_sel = 5;
						wdata_sel = 2;
						ALUop = 0;
						sel_PC = 1;
						br_type = 3'b111;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
					end
		7'b1100111: begin    // JALR Type Instruction
						rfwrite   = 1;
						Use_Imm   = 1;
						Extend_sel = 0;
						wdata_sel = 2;
						ALUop = 0;
						sel_PC = 0;
						br_type = 3'b111;
						csr_reg_rd = 0;
						csr_reg_wr = 0;
						is_mret = 0;
					end
		7'b1110011: begin    // CSR Type Instruction
						if (func3 == 3'd0) begin
							is_mret = 1;
							rfwrite   = 0;
							Use_Imm   = 0;
							Extend_sel = 0;
							wdata_sel = 0;
							ALUop = 0;
							sel_PC = 0;
							br_type = 0;
							csr_reg_rd = 0;
							csr_reg_wr = 0;
						end
						else begin
							rfwrite   = 1;
							Use_Imm   = 1;
							Extend_sel = 0;
							wdata_sel = 3;
							ALUop = 0;
							sel_PC = 0;
							br_type = 0;
							csr_reg_rd = 1;
							csr_reg_wr = 1;
							is_mret = 0;
						end
					end
	endcase

if (opcode == 7'b0110011 || opcode == 7'b0010011) begin	
	//Generating Signals for ALU
	case(func3)
		3'b000: begin
				unique if (func7 == 7'b0000000) 
					ALUop = 0; //Add
				else if (func7 == 7'b0100000 || opcode == 7'b1100011) 
					ALUop = 1; //Sub
				end
		3'b110: ALUop = 2; //OR
		3'b100: ALUop = 3; //XOR
		3'b111: ALUop = 4; //AND
		3'b010: begin
				unique if (opcode == 7'b0110011)
					ALUop = 5; //SLT
				else if (opcode == 7'b0000011)
					ALUop =  0; //Add
				else if (opcode == 7'b0100011)
					ALUop =  0; //Add				
				end
		3'b011: ALUop = 6; //SLTU
		3'b001: begin
				ALUop = 7; //SLL
				unique if (opcode == 7'b0010011)
					Extend_sel = 2;   // SLLI
		  		end
		3'b101: begin
				unique if (func7 == 7'b0000000)
					ALUop = 8; //SRL
					unique if (opcode == 7'b0010011) begin
						Extend_sel = 2;   // SRLI	
					end
				else if (func7 == 7'b0100000)
					ALUop = 9; //SRA
					unique if (opcode == 7'b0010011) begin
						Extend_sel = 2;   // SRAI	
					end
				end		
	endcase
end
end

endmodule