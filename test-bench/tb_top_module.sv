/*----------------------------------------------------------------
  Testbench for Project 2
------------------------------------------------------------------*/
module tb_Top_Module ();

logic clk , reset;

Top_Module dut (.clk(clk), .reset(reset));
parameter T = 10; // Clock Period
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
// reset_dut ;
reset = 0;
#350;
//$stop;
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