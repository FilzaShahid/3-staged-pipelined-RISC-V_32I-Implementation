/*----------------------------------------------------------------
  Module for Program Counter
------------------------------------------------------------------*/
module Program_Counter
	(
		input logic clk, reset, br_taken, Stall, control, 
		input logic[31:0] ALU_imm, epc,  // for B, JAL and JALR type
		output logic[31:0] PC
	); 

logic[31:0] PC_inter;

initial begin
	PC_inter = 32'd0;
	end
	
always@(posedge clk) begin 
	if (reset)
		PC_inter <= 32'd0;
	else begin
		if (Stall) begin
			PC_inter <= PC_inter;	
		end
		else begin
			if (control) PC_inter <= epc;
			else if (br_taken) PC_inter <= ALU_imm;
			else PC_inter <= PC_inter + 32'd4;
		end
	end
end

assign PC = PC_inter;

endmodule