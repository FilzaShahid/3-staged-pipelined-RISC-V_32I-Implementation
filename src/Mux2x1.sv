/*----------------------------------------------------------------
  Module for Multiplexer
------------------------------------------------------------------*/
module Mux2x1
    (
        input logic sel, 
        input logic[31:0] in1, in2, 
        output logic[31:0] result
    );

always_comb begin
	case (sel)
		0: result = in1;
		1: result = in2;
	endcase
	end
    
endmodule