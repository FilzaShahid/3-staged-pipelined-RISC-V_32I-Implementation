/*----------------------------------------------------------------
  Module for Register Files
------------------------------------------------------------------*/
module Register
	(
		input logic clk, rfwrite, 
		input logic[4:0] radd1, radd2, wadd, 
		input logic[31:0] wdata,
		output logic[31:0] rdata1, rdata2
	);
	
//32 Registers each 32-bit wide
logic[31:0] Register_Files [31:0];

initial begin
	$readmemh("reg.txt", Register_Files);
	end
	
//Synchronous Write
always_ff@ (posedge clk) begin
	if (rfwrite)
		Register_Files [wadd] = (|wadd) ? wdata: 32'b0;
	end
	
//Asynchronous Read
always_comb begin
	rdata1 = (|radd1) ? Register_Files[radd1] : 32'b0;
	rdata2 = (|radd2) ? Register_Files[radd2] : 32'b0;
	end
endmodule