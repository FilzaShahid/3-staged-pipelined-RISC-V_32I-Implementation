module InsFlip_Flop #( parameter WIDTH = 32)
    (
        input logic clk, reset, Flush, flush_interrupt,
        input logic [WIDTH-1:0] in,
        output logic [WIDTH-1:0] out
    );

    always_ff@(posedge clk) begin
        if (reset)
            out <= '0;
        else if (Flush || flush_interrupt)
            out <= 32'h00000013;
        else
            out <= in;
    end

endmodule

