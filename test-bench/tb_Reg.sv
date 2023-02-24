/*----------------------------------------------------------------
  Testbench for Register
------------------------------------------------------------------*/
`timescale 1ns/10ps
module tb_Register();

	parameter T = 10; 

	logic clk, rfwrite;
	logic [4:0] radd1, radd2, wadd;
	logic [31:0] wdata;
	bit [31:0] rdata1, rdata2;

	Register dut(.clk(clk), .rfwrite(rfwrite), .radd1(radd1), .radd2(radd2), .wadd(wadd), .wdata(wdata),
			 .rdata1(rdata1), .rdata2(rdata2));

/*----------------------------------------------------------------
  Clock Generator
------------------------------------------------------------------*/
initial
begin
clk = 0;
forever #(T/2) clk=~clk;
end

initial
begin
rfwrite <= 0;
radd1 <= 0;
radd2 <= 1;
wadd  <= 2;
wdata <= 9;
#50;
rfwrite <= 1;
radd1 <= 1;
radd2 <= 2;
wadd  <= 2;
wdata <= 9;
#50;
rfwrite <= 1;
radd1 <= 9;
radd2 <= 11;
wadd  <= 20;
wdata <= 55;
#50;
rfwrite <= 0;
radd1 <= 20;
radd2 <= 18;
wadd  <= 26;
wdata <= 44;
#50;
$stop;
end

endmodule