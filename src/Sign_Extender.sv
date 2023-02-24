/*----------------------------------------------------------------
  Module for Sign Extender 
------------------------------------------------------------------*/
module Sign_Extender 
    (
      input [2:0] Extend_sel,
      input logic[11:0] Imm, SImm,
      input logic[4:0] SLImm,
      input logic[19:0] UImm,
      input logic[12:0] BImm,
      input logic[20:0] JImm,
		  output logic[31:0] Extended_Imm
    );

always_comb begin
  case(Extend_sel)
    3'b000 : Extended_Imm = 32'(signed'(Imm));
    3'b001 : Extended_Imm = 32'(signed'(SImm));
    3'b010 : Extended_Imm = 32'(signed'(SLImm));
    3'b011 : Extended_Imm = {UImm, 12'b0};
    3'b100 : Extended_Imm = 32'(signed'(BImm));
    3'b101 : Extended_Imm = 32'(signed'(JImm));
  endcase
  end  

endmodule