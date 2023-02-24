module DE_to_MW
    (
        input logic clk, reset, rfwrite, csr_reg_rd, csr_reg_wr, is_mret,
        input logic [1:0] wdata_sel,
        input logic [31:0] PC, Alu_result, rdata2, rdata1, Instruction,
        output logic rfwrite_out, csr_reg_rd_out, csr_reg_wr_out, is_mret_MW,
        output logic [1:0] wdata_sel_out,
        output logic [31:0] PC_out, Alu_result_out, rdata2_out, rdata1_out, Instruction_out
    );

    Flip_Flop #(32) PC_buffer(clk, reset, PC, PC_out);

    Flip_Flop #(32) Alu_result_buffer(clk, reset, Alu_result, Alu_result_out);

    Flip_Flop #(32) rdata2_buffer(clk, reset, rdata2, rdata2_out);

    Flip_Flop #(32) Instruction_buffer(clk, reset, Instruction, Instruction_out);

    Flip_Flop #(2) wdata_sel_buffer(clk, reset, wdata_sel, wdata_sel_out);

    Flip_Flop #(1) rfwrite_buffer(clk, reset, rfwrite, rfwrite_out);

    Flip_Flop #(32) rdata1_buffer(clk, reset, rdata1, rdata1_out);

    Flip_Flop #(1) csr_reg_rd_buffer(clk, reset, csr_reg_rd, csr_reg_rd_out);

    Flip_Flop #(1) csr_reg_wr_buffer(clk, reset, csr_reg_wr, csr_reg_wr_out);

    Flip_Flop #(1) is_mret_buffer(clk, reset, is_mret, is_mret_MW);

endmodule