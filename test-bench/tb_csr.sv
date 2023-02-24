/*----------------------------------------------------------------
  Testbench for Project 2
------------------------------------------------------------------*/
module tb_CSR_Regfile ();

logic clk , reset, intr_expc, reg_wr;
logic [11:0] addr_csr;
logic [31:0] PC_MW, csr_wdata, csr_rdata, epc_evec;

CSR_RegFile dut (.clk(clk), .reset(reset), .intr_expc(intr_expc), .reg_wr(reg_wr), .addr_csr(addr_csr), 
                .PC_MW(PC_MW), .csr_wdata(csr_wdata), .csr_rdata(csr_rdata), .epc_evec(epc_evec));

parameter T = 10; // Clock Period
/*----------------------------------------------------------------
  Clock Generator
------------------------------------------------------------------*/
initial
begin
clk = 0;
forever #(T/2) clk=~clk;
end

initial begin
reset = 1;
@(posedge clk);
reset = 0;
reg_wr = 1;
csr_wdata = 32'd326;
addr_csr = 12'h344;
@(posedge clk);
addr_csr = 12'h305;
csr_wdata = 32'h673;
@(posedge clk);
reg_wr = 0;
addr_csr = 12'h305;
@(posedge clk);
addr_csr = 12'h344;
$stop;
end
endmodule