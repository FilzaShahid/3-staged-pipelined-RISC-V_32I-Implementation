/*----------------------------------------------------------------
  Module for Multiplexer
------------------------------------------------------------------*/
module Mux3x1
    (
        input logic[1:0] sel, 
        input logic[31:0] in1, in2, in3,
        output logic[31:0] result
    );

always_comb begin
	case (sel)
		2'b00: result = in1;
		2'b01: result = in2;
        2'b10: result = in3;
	endcase
	end
    
endmodule