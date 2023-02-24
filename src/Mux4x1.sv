/*----------------------------------------------------------------
  Module for Multiplexer
------------------------------------------------------------------*/
module Mux4x1
    (
        input logic[1:0] sel, 
        input logic[31:0] in1, in2, in3, in4,
        output logic[31:0] result
    );

always_comb begin
	case (sel)
		2'b00: result = in1;
		2'b01: result = in2;
        2'b10: result = in3;
        2'b11: result = in4;
	endcase
	end
    
endmodule