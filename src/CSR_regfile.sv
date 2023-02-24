module CSR_RegFile
    (
        input logic clk, reset, intr_expc, reg_wr, reg_rd, is_mret,
        input logic [11:0] addr_csr,
        input logic [31:0] PC_MW, csr_wdata,
        output logic control = '0, flush_interrupt = '0,
        output logic [31:0] csr_rdata, epc  
    );

    parameter MSTATUS = 12'h300;
    parameter MIE = 12'h304;
    parameter MTVEC = 12'h305;
    parameter MEPC = 12'h341;
    parameter MCAUSE = 12'h342;
    parameter MIP = 12'h344;

    logic [31:0] csr_mcause_ff = '0;
    logic [31:0] csr_mepc_ff = '0; 
    logic [31:0] csr_mie_ff = '0; 
    logic [31:0] csr_mip_ff = '0;
    logic [31:0] csr_mstatus_ff = '0; 
    logic [31:0] csr_mtvec_ff = '0;
    logic csr_mcause_wr_flag, csr_mepc_wr_flag, csr_mie_wr_flag, csr_mip_wr_flag, csr_mstatus_wr_flag, csr_mtvec_wr_flag;

    always_comb begin 
        // csr read operation
        csr_rdata = '0;
        if (reg_rd) begin
            case(addr_csr)
                MSTATUS : csr_rdata = csr_mstatus_ff;
                MIE : csr_rdata = csr_mie_ff;
                MTVEC : csr_rdata = csr_mtvec_ff;
                MEPC : csr_rdata = csr_mepc_ff;
                MCAUSE : csr_rdata = csr_mcause_ff;
                MIP : csr_rdata = csr_mip_ff;
            endcase
        end

        // csr write operation
        csr_mstatus_wr_flag = 1'b0;
        csr_mie_wr_flag = 1'b0;
        csr_mtvec_wr_flag = 1'b0;
        csr_mepc_wr_flag = 1'b0;
        csr_mcause_wr_flag = 1'b0;
        csr_mip_wr_flag = 1'b0;

        if (reg_wr) begin
            case(addr_csr)
                MSTATUS : csr_mstatus_wr_flag = 1'b1;
                MIE : csr_mie_wr_flag = 1'b1;
                MTVEC : csr_mtvec_wr_flag = 1'b1;
                MEPC : csr_mepc_wr_flag = 1'b1;
                MCAUSE : csr_mcause_wr_flag = 1'b1;
                MIP : csr_mip_wr_flag = 1'b1;
            endcase
        end

        if (intr_expc) begin
            csr_mcause_ff[31] = 1;
            csr_mip_ff[7] = 1;
        end
    end

    always_ff @( negedge reset, posedge clk ) begin
        // set to zero 
        control <= '0;
        flush_interrupt <= '0;

        if (reset) begin
            csr_mtvec_ff <= {32{1'b0}};
            csr_mstatus_ff <= {32{1'b0}};
            csr_mie_ff <= {32{1'b0}};
            csr_mepc_ff <= {32{1'b0}};
            control <= '0;
            flush_interrupt <= '0;
            epc <= '0;
        end

        else if (intr_expc) begin
            if (csr_mstatus_ff[3] && (csr_mip_ff[7] && csr_mie_ff[7])) begin
                csr_mepc_ff <= PC_MW;
                control <= 1;
                flush_interrupt <= 1;
                if (csr_mtvec_ff[1:0] == 1)  // vector mode
                    epc <= csr_mtvec_ff + (csr_mcause_ff << 2);
                else if (csr_mtvec_ff[1:0] == 0) // direct mode
                    epc <= csr_mtvec_ff;
            end
            else begin
                epc <= {32{1'b0}};
                control <= '0;
                flush_interrupt <= '0;
                csr_mepc_ff <= '0;
            end     
        end

        // return instruction
        else if (is_mret) begin
            epc <= csr_mepc_ff;
            control <= 1;
        end

        // Update mtvec CSR    
        else if (csr_mtvec_wr_flag) begin
            csr_mtvec_ff <= csr_wdata;
        end

        // Update mstatus CSR
        else if (csr_mstatus_wr_flag) begin
            csr_mstatus_ff <= csr_wdata;
        end

        // Update mie CSR
        else if (csr_mie_wr_flag) begin
            csr_mie_ff <= csr_wdata;
        end
            
        // Update mepc CSR     
        else if (csr_mepc_wr_flag) begin
            csr_mepc_ff <= csr_wdata;
        end
    end


endmodule