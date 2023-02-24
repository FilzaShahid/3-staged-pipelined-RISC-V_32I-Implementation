/*----------------------------------------------------------------
  Module for Decoding Instructions
------------------------------------------------------------------*/

module Decoder
    (
        input logic[31:0] Instruction,
        output logic[4:0] radd1, radd2, wadd, SLImm,
        output logic[2:0] func3, 
        output logic[6:0] func7, opcode,
        output logic[11:0] Imm, SImm,
        output logic[12:0] BImm,
        output logic[19:0] UImm,
        output logic[20:0] JImm
    );

assign radd1 = Instruction[19:15];              // getting addresses for register file
assign radd2 = Instruction[24:20];
assign wadd  = Instruction[11:7];

assign func3  = Instruction[14:12];             //Signals to Controller
assign func7  = Instruction[31:25];
assign opcode = Instruction[6:0];

assign Imm = Instruction[31:20];    // I type, JALR, Load, CSR instruction

assign SLImm = Instruction[24:20];   // I type Shift instruction

assign SImm[11:5] = Instruction[31:25];         //Store instruction
assign SImm[4:0]  = Instruction[11:7];

assign UImm = Instruction[31:12];     // U type instruction

assign BImm = {Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0};   //B type instruction

assign JImm = {Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0};  //J Type instruction

endmodule