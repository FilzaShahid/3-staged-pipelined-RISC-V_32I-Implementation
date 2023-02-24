module timer
    (
        input logic clk, reset,
        output logic intr_expc
    );

    logic[31:0] count = '0;

    always_ff@(posedge clk) begin
        if (reset || count == 20) begin
            count <= 0;
        end
        else begin 
            count <= count + 32'd1;
        end
    end

    always_comb begin
        if (reset || count == 20) begin
            intr_expc = 1;
        end
        else begin
            intr_expc = 0;
        end
    end

endmodule