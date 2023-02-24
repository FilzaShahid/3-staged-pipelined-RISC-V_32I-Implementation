/*----------------------------------------------------------------
  Module for ALU
------------------------------------------------------------------*/
module ALU
	(
		input logic[31:0] op1, op2, 
		input logic[3:0] ALUop, 
		output logic[31:0] ALUresult
	);
	
always_comb begin
	case (ALUop)
		//Add
		0: ALUresult = op1 + op2;
		//Subtract
		1: ALUresult = op1 - op2;
		//OR
		2: ALUresult = op1 | op2;
		//XOR
		3: ALUresult = op1 ^ op2;
		//AND
		4: ALUresult = op1 & op2;
		//SLT
		5: ALUresult = $signed(op1) < $signed(op2);
		//SLTU
		6: ALUresult = op1 < op2;
		//SLL
		7: ALUresult = op1 << op2;
		//SRL
		8: ALUresult = op1 >> op2;
		//SRA
		9: ALUresult = op1 >>> op2;
	endcase
end
endmodule
