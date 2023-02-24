module Flip_Flop #( parameter WIDTH = 32)
    (
        input logic clk, reset, 
        input logic [WIDTH-1:0] in,
        output logic [WIDTH-1:0] out
    );

    always_ff@(posedge clk) begin
        if (reset)
            out <= '0;
        else
            out <= in;
    end

endmodule

