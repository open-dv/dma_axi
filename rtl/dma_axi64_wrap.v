module dma_axi64_wrap(clk,reset,scan_en,idle,INT,periph_tx_req,periph_tx_clr,periph_rx_req,periph_rx_clr,pclken,psel,penable,paddr,pwrite,pwdata,prdata,pslverr,pready);

   
   input                                clk;
   input                 reset;
   input                 scan_en;

   output                 idle;
   output [1-1:0]                INT;
   
   input [31:1]             periph_tx_req;
   output [31:1]             periph_tx_clr;
   input [31:1]             periph_rx_req;
   output [31:1]             periph_rx_clr;

   input                                pclken;
   input                                psel;
   input                                penable;
   input [12:0]                         paddr;
   input                                pwrite;
   input [31:0]                         pwdata;
   output [31:0]                        prdata;
   output                               pslverr;
   output                               pready;
   
    wire [`ID_BITS-1:0]               w_AWID0;
    wire [32-1:0]                     w_AWADDR0;
    wire [`LEN_BITS-1:0]              w_AWLEN0;
    wire [`SIZE_BITS-1:0]             w_AWSIZE0;
    wire                              w_AWVALID0;
    wire                              w_AWREADY0;
    wire [`ID_BITS-1:0]               w_WID0;
    wire [64-1:0]                     w_WDATA0;
    wire [64/8-1:0]                   w_WSTRB0;
    wire                              w_WLAST0;
    wire                              w_WVALID0;
    wire                              w_WREADY0;
    wire[`ID_BITS-1:0]                w_BID0;
    wire[1:0]                         w_BRESP0;
    wire                              w_BVALID0;
    wire                              w_BREADY0;
    wire [`ID_BITS-1:0]               w_ARID0;
    wire [32-1:0]                     w_ARADDR0;
    wire [`LEN_BITS-1:0]              w_ARLEN0;
    wire [`SIZE_BITS-1:0]             w_ARSIZE0;
    wire                              w_ARVALID0;
    wire                              w_ARREADY0;
    wire[`ID_BITS-1:0]                w_RID0;
    wire[64-1:0]                      w_RDATA0;
    wire[1:0]                         w_RRESP0;
    wire                              w_RLAST0;
    wire                              w_RVALID0;
    wire                              w_RREADY0;

	assign w_RDATA0 = 'h20;
	
dma_axi64
u_dma_axi64 (
	.clk(clk),
	.reset(reset),
	.scan_en(scan_en),
	
	 .idle(idle),
	 .INT(INT),
	 .periph_tx_req(periph_tx_req),
	 .periph_tx_clr(periph_tx_clr),
	 .periph_rx_req(periph_rx_req),
	 .periph_rx_clr(periph_rx_clr),
	 .pclken(pclken),
	 .psel(psel),
	 .penable(penable),
	 .paddr(paddr),
	 .pwrite(pwrite),
	 .pwdata(pwdata),
	 .prdata(prdata),
	 .pslverr(pslverr),
	 .pready(pready),
		
	 .AWID0(w_AWID0),          
	 .AWADDR0(w_AWADDR0),
	 .AWLEN0(w_AWLEN0),
	 .AWSIZE0(w_AWSIZE0),
	 .AWVALID0(w_AWVALID0),
	 .AWREADY0(w_AWREADY0),
	 .WID0(w_WID0),
	 .WDATA0(w_WDATA0),
	 .WSTRB0(w_WSTRB0),
	 .WLAST0(w_WLAST0),
	 .WVALID0(w_WVALID0),
	 .WREADY0(w_WREADY0),
	 .BID0(w_BID0),
	 .BRESP0(w_BRESP0),
	 .BVALID0(w_BVALID0),
	 .BREADY0(w_BREADY0),
	 .ARID0(w_ARID0),
	 .ARADDR0(w_ARADDR0),
	 .ARLEN0(w_ARLEN0),
	 .ARSIZE0(w_ARSIZE0),
	 .ARVALID0(w_ARVALID0),
	 .ARREADY0(w_ARREADY0),
	 .RID0(w_RID0),
	 .RDATA0(w_RDATA0),
	 .RRESP0(w_RRESP0),
	 .RLAST0(w_RLAST0),
	 .RVALID0(w_RVALID0),
	 .RREADY0(w_RREADY0)
);
   
   
axi_slave
u_axi_slave (
    .clk(clk),
	.reset(reset),
	.AWID(w_AWID0),
	.AWADDR(w_AWADDR0),
	.AWLEN(w_AWLEN0),
	.AWSIZE(w_AWSIZE0),
	.AWBURST(0),
	.AWCACHE(0),
	.AWPROT(0),
	.AWLOCK(0),
	.AWVALID(w_AWVALID0),
	.AWREADY(w_AWREADY0),
	.WID(w_WID0),
	.WDATA(w_WDATA0),
	.WSTRB(w_WSTRB0),
	.WLAST(w_WLAST0),
	.WVALID(w_WVALID0),
	.WREADY(w_WREADY0),
	.BID(w_BID0),
	.BRESP(w_BRESP0),
	.BVALID(w_BVALID0),
	.BREADY(w_BREADY0),
	.ARID(w_ARID0),
	.ARADDR(w_ARADDR0),
	.ARLEN(w_ARLEN0),
	.ARSIZE(w_ARSIZE0),
	.ARBURST(0),
	.ARCACHE(0),
	.ARPROT(0),
	.ARLOCK(0),
	.ARVALID(w_ARVALID0),
	.ARREADY(w_ARREADY0),
	.RID(w_RID0),
	.RDATA(),
	.RRESP(w_RRESP0),
	.RLAST(w_RLAST0),
	.RVALID(w_RVALID0),
	.RREADY(w_RREADY0)
	
);	

endmodule