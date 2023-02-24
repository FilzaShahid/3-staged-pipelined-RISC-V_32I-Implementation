/*----------------------------------------------------------------
  Module for Load Store Unit
------------------------------------------------------------------*/
module Load_Store_Unit 
    (
        input logic [2:0] func3,
        input logic [6:0] opcode,
        input logic [31:0] LSU_In, Mem_Addr,
        output logic cs, rd_wr,
        output logic [3:0] mask,
        output logic [31:0] LSU_Out
    );


always_comb begin
    // Store Unit
    if (opcode == 7'b0100011) begin
        cs = 1'b0;
        rd_wr = 1'b0;
        // selecting the required size and location for storing
         case(func3) 
            3'b000 : begin  // SB
                case(Mem_Addr[1:0])
                    2'b00 : begin
                        mask = 4'b0001;
                    end
                    2'b01 : begin
                        mask = 4'b0010;
                    end
                    2'b10 : begin
                        mask = 4'b0100;
                    end
                    2'b11 : begin
                        mask = 4'b1000;
                    end
                endcase
            end
            3'b001 : begin   // SH
                case(Mem_Addr[1])
                    1'b0 : begin
                        mask = 4'b0011;
                    end
                    1'b1 : begin
                        mask = 4'b1100;
                    end
                endcase
            end
            3'b010 : begin
                mask = 4'b1111;  // SW
            end
            default: begin
                mask = 4'b0000;
            end
         endcase
    end

    // Load Unit
    if (opcode == 7'b0000011) begin
        cs = 1'b0;
        rd_wr = 1'b1;
    // selecting the required size of the loaded memory
        case (func3)
            3'b000 : begin   // LB
                case(Mem_Addr[1:0]) 
                    2'b00 : LSU_Out = {{24{LSU_In[7]}}, {LSU_In[7:0]}};
                    2'b01 : LSU_Out = {{24{LSU_In[15]}}, {LSU_In[15:8]}}; 
                    2'b10 : LSU_Out = {{24{LSU_In[23]}}, {LSU_In[23:16]}};
                    2'b11 : LSU_Out = {{24{LSU_In[31]}}, {LSU_In[31:24]}}; 
                endcase
            end 
            3'b100 : begin  // LBU
                case(Mem_Addr[1:0]) 
                    2'b00 : LSU_Out = {24'b0, {LSU_In[7:0]}};  
                    2'b01 : LSU_Out = {24'b0, {LSU_In[15:8]}};
                    2'b10 : LSU_Out = {24'b0, {LSU_In[23:16]}};  
                    2'b11 : LSU_Out = {24'b0, {LSU_In[31:24]}};
                endcase
            end 
            3'b001 : begin  // LH
                case(Mem_Addr[1]) 
                    1'b0 : LSU_Out = {{16{LSU_In[15]}}, {LSU_In[15:0]}}; 
                    1'b1 : LSU_Out = {{16{LSU_In[31]}}, {LSU_In[31:16]}};  
                endcase
            end
            3'b101 : begin   // LHU
                case(Mem_Addr[1]) 
                    1'b0 : LSU_Out = {16'b0, {LSU_In[15:0]}}; 
                    1'b1 : LSU_Out = {16'b0, {LSU_In[31:16]}};
                endcase
            end    
            3'b010 : LSU_Out = LSU_In;    // LW
            default: LSU_Out = 32'b0;
        endcase
    end
end
	
endmodule