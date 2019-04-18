
`timescale 1ns/1ps


module tb_top();
    // include and import uvm_pkg
    `include "uvm_macros.svh"
    import uvm_pkg::*;    
    
    // import test pkg
    import apb_test_pkg::*;
    
    // clock declaration
    bit clk_100MHz;

     
    wire                 w_reset;
    wire                 w_scan_en;

    wire                 w_idle;
    wire [1-1:0]         w_INT;
   
    wire [31:1]          w_periph_tx_req;
    wire [31:1]         w_periph_tx_clr;
    wire [31:1]          w_periph_rx_req;
    wire [31:1]         w_periph_rx_clr;

   wire                                w_pclken;
   wire                                w_psel;
   wire                                w_penable;
   wire [12:0]                         w_paddr;
   wire                                w_pwrite;
   wire [31:0]                         w_pwdata;
   wire  [31:0]                        w_prdata;
   wire                                w_pslverr;
   wire                                w_pready;
	
	
    // interface declaration
    apb_interface   apb_intf(clk_100MHz);
    
    // 100MHz clock generation block
    initial begin
        forever begin
            #(5ns) clk_100MHz = ~clk_100MHz;
        end
    end

	assign w_scan_en = 0;
	
	assign w_reset = !apb_intf.PRESETn; 
	assign w_pclken = 1'b1;
	assign w_psel = apb_intf.PSEL;    
	assign w_penable = apb_intf.PENABLE; 
	assign w_pwrite = apb_intf.PWRITE;  
	assign w_paddr = apb_intf.PADDR;   
	assign w_pwdata = apb_intf.PWDATA;  
	assign apb_intf.PRDATA = w_prdata;  
	assign apb_intf.PREADY = w_pready;  
	assign apb_intf.PSLVERR = w_pslverr; 

	dma_axi64_wrap u_dma_axi64_wrap(
		.clk(clk_100MHz),
		.reset(w_reset),
		.scan_en(w_scan_en),
	
		.idle(w_idle),
		.INT(w_INT),
		.periph_tx_req(w_periph_tx_req),
		.periph_tx_clr(w_periph_tx_clr),
		.periph_rx_req(w_periph_rx_req),
		.periph_rx_clr(w_periph_rx_clr),
		.pclken(w_pclken),
		.psel(w_psel),
		.penable(w_penable),
		.paddr(w_paddr),
		.pwrite(w_pwrite),
		.pwdata(w_pwdata),
		.prdata(w_prdata),
		.pslverr(w_pslverr),
		.pready(w_pready)
	);		
	
    
                    
    // set interface in uvm config db 
    initial begin
        uvm_config_db#(virtual apb_interface)::set(null, "*", "APB_INTF", apb_intf);
        // start the test
       run_test();
    end
	
	// Dump waves
    initial $dumpvars(0, tb_top);
    
endmodule: tb_top