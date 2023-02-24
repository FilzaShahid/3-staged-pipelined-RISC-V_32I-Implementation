module F_to_DE
    (
        input logic clk, reset, Flush, flush_interrupt,
        input logic [31:0] PC, Instruction,
        output logic [31:0] PC_out, Instruction_out
    );

    Flip_Flop #(32) PC_buffer(clk, reset, PC, PC_out);

    InsFlip_Flop #(32) Instruction_buffer(clk, reset, Flush, flush_interrupt, Instruction, Instruction_out);  
    
endmodule