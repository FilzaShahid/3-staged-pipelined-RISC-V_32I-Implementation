/*----------------------------------------------------------------
  Module for Instruction Memory
------------------------------------------------------------------*/
module Instruction_Memory
	(
		input logic[31:0] PC, 
		output logic[31:0] Instruction
	);
	
//1024 Instructions each 8-bit wide
logic[7:0] Instruction_Files [511:0];

initial begin
	$readmemh("ins.txt", Instruction_Files);
	end
	
always_comb begin
	Instruction = {Instruction_Files[PC], Instruction_Files[PC+1], Instruction_Files[PC+2], Instruction_Files[PC+3]};
end	

endmodule