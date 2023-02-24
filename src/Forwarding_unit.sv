module Forwarding_Unit 
    (
        input logic [31:0] Instruction, Instruction_DE, Instruction_MW,
        input logic rfwrite_MW, br_taken,
        output logic For_A, For_B, Stall, Flush
    );

logic [4:0] radd1_DE, radd2_DE, wadd_MW, radd1, radd2, wadd;
logic wadd_valid, wadd_v;
logic [6:0] opcode;

always_comb begin 
    radd1_DE = Instruction_DE[19:15];
    radd2_DE = Instruction_DE[24:20];
    wadd_MW = Instruction_MW[11:7];
    wadd_valid = |wadd_MW;

    radd1 = Instruction[19:15];
    radd2 = Instruction[24:20];
    wadd = Instruction_DE[11:7];
    wadd_v = |wadd;
    opcode = Instruction_DE[6:0];

    if ((wadd_MW == radd1_DE) && rfwrite_MW && wadd_valid)
        For_A = 1'b1;
    else
        For_A = 1'b0;

    if ((wadd_MW == radd2_DE) && rfwrite_MW && wadd_valid)
        For_B = 1'b1;
    else
        For_B = 1'b0;

    if (br_taken)
        Flush = 1'b1;
    else
        Flush = 1'b0;

    if ((wadd == radd2|| wadd == radd1) && (opcode == 7'b0000011) && wadd_v)
        Stall = 1'b1;
    else 
        Stall = 1'b0;

end
endmodule