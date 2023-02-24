/*----------------------------------------------------------------
  Testbench for Instruction Memory
------------------------------------------------------------------*/
module tb_InstructionMem ();

logic [31:0] PC;
bit [31:0] Instruction;

Instruction_Memory dut (.PC(PC), .Instruction(Instruction));


initial
begin
PC <= 0;
#1;
PC <= 4;
#1;
PC <= 8;
#1;
$stop;
end

endmodule