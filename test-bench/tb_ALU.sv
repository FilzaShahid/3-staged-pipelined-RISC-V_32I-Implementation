/*----------------------------------------------------------------
  Testbench for ALU
------------------------------------------------------------------*/
module tb_ALU ();

logic [31:0] op1, op2;
logic[3:0] ALUop;
bit [31:0] ALUresult;
ALU dut (.op1(op1), .op2(op2), .ALUop(ALUop), .ALUresult(ALUresult));
parameter T = 10; 

initial
begin
op1 <= 10;
op2 <= 5;
ALUop <= 0;
#1;

ALUop <= 1;
#1;

ALUop <= 2;
#1;

ALUop <= 3;
#1;

ALUop <= 4;
#1;

ALUop <= 5;
#1;

ALUop <= 6;
#1;

ALUop <= 7;
#1;

ALUop <= 8;
#1;

ALUop <= 9;
#1;
$stop;
end

endmodule