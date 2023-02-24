/*----------------------------------------------------------------
  Module for Branch Comparison
------------------------------------------------------------------*/

module Branch_Comparator
    (
        input logic [31:0] rdata1, rdata2,
        input logic [2:0] br_type,
        output logic br_taken
    );
always_comb begin
    case(br_type) 
        3'b001 : br_taken = rdata1 == rdata2;    // BEQ
        3'b010 : br_taken = rdata1 != rdata2;    // BNE
        3'b011 : br_taken = $signed(rdata1) < $signed(rdata2);    // BLT
        3'b100 : br_taken = $signed(rdata1) >= $signed(rdata2);   // BGE
        3'b101 : br_taken = rdata1 < rdata2;     // BLTU
        3'b110 : br_taken = rdata1 >= rdata2;    // BGEU
        3'b111 : br_taken = 1;   // JAL
        default : br_taken = 0;
    endcase
end

endmodule