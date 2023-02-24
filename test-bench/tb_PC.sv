/*----------------------------------------------------------------
  Testbench for Program Counter
------------------------------------------------------------------*/
module tb_PC ();

parameter T = 10; // Clock Period

logic clk , reset;
bit [31:0] PC;

Program_Counter dut (.clk(clk), .reset(reset), .PC(PC));
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
reset_dut ;
#20;
#20;
end
/*----------------------------------------------------------------
  Reset Sequence
------------------------------------------------------------------*/
task reset_dut ;
begin
reset <= 1;
#(T/4); reset <= 0;
end
endtask
endmodule