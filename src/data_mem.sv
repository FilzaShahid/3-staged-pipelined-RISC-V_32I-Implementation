module Data_Memory 
    (
        input logic clk, cs, rd_wr,
        input logic [3:0] mask,
        input logic [31:0] Mem_Addr, Mem_In, 
        output logic [31:0] Mem_Out);

logic [31:0] Data_File [31:0];

initial begin
	$readmemh("data.txt", Data_File);
	end

always_ff @(negedge clk) begin
	// Storing Data from Register Files into Data Memory
	if (!cs && !rd_wr) begin
        if (mask[0])
		    Data_File[Mem_Addr[31:2]][7:0] = Mem_In[7:0];
        if (mask[1])
		    Data_File[Mem_Addr[31:2]][15:8] = Mem_In[15:8];
        if (mask[2])
		    Data_File[Mem_Addr[31:2]][23:16] = Mem_In[23:16];
        if (mask[3])
		    Data_File[Mem_Addr[31:2]][31:24] = Mem_In[31:24];
        end
end

always_comb begin
        // Loading Data from Data Memory to Register Files
	    if (!cs && rd_wr) begin
		    Mem_Out = Data_File[Mem_Addr[31:2]];
        end
        else begin
            Mem_Out = 32'b0;
        end
end

endmodule