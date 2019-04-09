//------------------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- RobustVerilog version 1.2 (limited free version)
//-- Invoked Sun Mar 24 15:39:38 2019
//-- Source file: axi_slave_ram.v
//-- Parent file: axi_slave.v
//-- Run directory: E:/vlsi/axi_slave/run/
//-- Target directory: out/
//-- Command flags: ../src/base/axi_slave.v -od out -I ../src/gen -list list.txt -listpath -header -gui 
//-- www.provartec.com/edatools ... info@provartec.com
//------------------------------------------------------------------





  
module axi_slave_ram(clk,reset,AWID,AWADDR,AWLEN,AWSIZE,AWBURST,AWCACHE,AWPROT,AWLOCK,AWVALID,AWREADY,WID,WDATA,WSTRB,WLAST,WVALID,WREADY,BID,BRESP,BVALID,BREADY,ARID,ARADDR,ARLEN,ARSIZE,ARBURST,ARCACHE,ARPROT,ARLOCK,ARVALID,ARREADY,RID,RDATA,RRESP,RLAST,RVALID,RREADY,WR,RD,ADDR_WR,ADDR_RD,DIN,BSEL,DOUT);

   input               clk;
   input               reset;
   
   input [3:0]                AWID;
   input [31:0]               AWADDR;
   input [3:0]                AWLEN;
   input [1:0]                AWSIZE;
   input [1:0]                AWBURST;
   input [3:0]                AWCACHE;
   input [2:0]                AWPROT;
   input [1:0]                AWLOCK;
   input                      AWVALID;
   output                     AWREADY;
   input [3:0]                WID;
   input [63:0]               WDATA;
   input [64/8-1:0]           WSTRB;
   input                      WLAST;
   input                      WVALID;
   output                     WREADY;
   output [3:0]               BID;
   output [1:0]               BRESP;
   output                     BVALID;
   input                      BREADY;
   input [3:0]                ARID;
   input [31:0]               ARADDR;
   input [3:0]                ARLEN;
   input [1:0]                ARSIZE;
   input [1:0]                ARBURST;
   input [3:0]                ARCACHE;
   input [2:0]                ARPROT;
   input [1:0]                ARLOCK;
   input                      ARVALID;
   output                     ARREADY;
   output [3:0]               RID;
   output [63:0]              RDATA;
   output [1:0]               RRESP;
   output                     RLAST;
   output                     RVALID;
   input                      RREADY;

   output                     WR;
   output                     RD;
   output [31:0]              ADDR_WR;
   output [31:0]              ADDR_RD;
   output [63:0]              DIN;
   output [64/8-1:0]          BSEL;
   input [63:0]               DOUT;
   
   
   //busy
   wire               ARBUSY;
   wire               RBUSY;
   wire               AWBUSY;
   wire               WBUSY;
   wire               BBUSY;
   
   //wcmd fifo
   wire [32-1:0]       wcmd_addr;
   wire [4-1:0]           wcmd_id;
   wire [2-1:0]       wcmd_size;
   wire [4-1:0]        wcmd_len;
   wire [1:0]               wcmd_resp;
   wire               wcmd_timeout;
   wire               wcmd_ready;
   wire               wcmd_empty;
   wire               wcmd_full;
   
   //rcmd fifo
   wire [32-1:0]       rcmd_addr;
   wire [4-1:0]           rcmd_id;
   wire [2-1:0]       rcmd_size;
   wire [4-1:0]        rcmd_len;
   wire [1:0]               rcmd_resp;
   wire               rcmd_timeout;
   wire               rcmd_ready;
   wire               rcmd_empty;
   wire               rcmd_full;

   wire [4-1:0]           rcmd_id2;
   wire [4-1:0]        rcmd_len2;

   wire               wresp_empty;
   wire               wresp_pending;
   wire               wresp_timeout;
   
   reg [32-1:0]           TIMEOUT_AR_addr = {32{1'b1}};
   reg [32-1:0]           TIMEOUT_AW_addr = {32{1'b1}};
   wire               AR_stall = ARVALID & (TIMEOUT_AR_addr == ARADDR);
   wire               AW_stall = AWVALID & (TIMEOUT_AW_addr == AWADDR);
   
   wire               RD_last;

   assign               RID   = rcmd_id2;

   //give ready only after VALID comes
   assign                     ARREADY = ((~rcmd_full) & (~AR_stall) & (~ARBUSY)) & ARVALID;
   assign                     AWREADY = ((~wcmd_full) & (~AW_stall) & (~AWBUSY)) & AWVALID;
   
  // assign                     ARREADY = ((~rcmd_full) & (~AR_stall) & (~ARBUSY)) || (~ARVALID);
  // assign                     AWREADY = ((~wcmd_full) & (~AW_stall) & (~AWBUSY)) || (~AWVALID);
   assign               BVALID  = (~wresp_timeout) & (wresp_pending ? (~wresp_empty) : (~wresp_empty) & (~BBUSY));

   axi_slave_busy
     axi_slave_busy (
           .clk(clk),
           .reset(reset),
           .ARBUSY(ARBUSY),
           .RBUSY(RBUSY),
           .AWBUSY(AWBUSY),
           .WBUSY(WBUSY),
           .BBUSY(BBUSY)
           );

   axi_slave_cmd_fifo #(8)
   axi_slave_wcmd_fifo (
              .clk(clk),
              .reset(reset),
              .AADDR(AWADDR),
              .AID(AWID),
              .ASIZE(AWSIZE),
              .ALEN(AWLEN),
              .AVALID(AWVALID),
              .AREADY(AWREADY),
              .VALID(WVALID),
              .READY(WREADY),
              .LAST(WLAST),
              .cmd_addr(wcmd_addr),
              .cmd_id(wcmd_id), //not used
              .cmd_size(wcmd_size),
              .cmd_len(wcmd_len), //not used
              .cmd_resp(),
              .cmd_timeout(wcmd_timeout),
              .cmd_ready(wcmd_ready),
              .cmd_empty(wcmd_empty),
              .cmd_full(wcmd_full)
              );

   
   axi_slave_cmd_fifo #(8)
   axi_slave_rcmd_fifo (
              .clk(clk),
              .reset(reset),
              .AADDR(ARADDR),
              .AID(ARID),
              .ASIZE(ARSIZE),
              .ALEN(ARLEN),
              .AVALID(ARVALID),
              .AREADY(ARREADY),
              .VALID(RD_last),
              .READY(1'b1),
              .LAST(1'b1),
              .cmd_addr(rcmd_addr),
              .cmd_id(rcmd_id),
              .cmd_size(rcmd_size),
              .cmd_len(rcmd_len),
              .cmd_resp(rcmd_resp),
              .cmd_timeout(rcmd_timeout),
              .cmd_ready(rcmd_ready),
              .cmd_empty(),
              .cmd_full()
              );
   
   axi_slave_cmd_fifo #(8)
   axi_slave_rcmd_fifo2 (
               .clk(clk),
               .reset(reset),
               .AADDR(ARADDR),
               .AID(ARID),
               .ASIZE(ARSIZE),
               .ALEN(ARLEN),
               .AVALID(ARVALID),
               .AREADY(ARREADY),
               .VALID(RVALID),
               .READY(RREADY),
               .LAST(RLAST),
               .cmd_addr(),
               .cmd_id(rcmd_id2),
               .cmd_size(),
               .cmd_len(rcmd_len2),
               .cmd_resp(),
               .cmd_timeout(),
               .cmd_ready(),
               .cmd_empty(rcmd_empty),
               .cmd_full(rcmd_full)
               );
   
   axi_slave_wresp_fifo #(8)
     axi_slave_wresp_fifo (
             .clk(clk),
             .reset(reset),
             .AWVALID(AWVALID),
             .AWREADY(AWREADY),
             .AWADDR(AWADDR),
             .WVALID(WVALID),
             .WREADY(WREADY),
             .WLAST(WLAST),
             .WID(WID),
             .BID(BID),
             .BRESP(BRESP),
             .BVALID(BVALID),
             .BREADY(BREADY),
             .empty(wresp_empty),
             .pending(wresp_pending),
             .timeout(wresp_timeout)
             );
   
   axi_slave_addr_gen
     axi_slave_addr_gen_wr (
              .clk(clk),
              .reset(reset),
              .cmd_addr(wcmd_addr),
              .cmd_size(wcmd_size),
              .advance(WVALID & WREADY & (~WLAST)),
              .restart(WVALID & WREADY & WLAST),
              .ADDR(ADDR_WR)
              );


   axi_slave_addr_gen
     axi_slave_addr_gen_rd (
              .clk(clk),
              .reset(reset),
              .cmd_addr(rcmd_addr),
              .cmd_size(rcmd_size),
              .advance(RD),
              .restart(RD_last),
              .ADDR(ADDR_RD)
              );
   
   axi_slave_rd_buff
   axi_slave_rd_buff(
           .clk(clk),
           .reset(reset),
           .RD(RD),
           .DOUT(DOUT),
           .rcmd_len(rcmd_len),
           .rcmd_len2(rcmd_len2),
           .rcmd_resp(rcmd_resp),
           .rcmd_timeout(rcmd_timeout),
           .rcmd_ready(rcmd_ready),
           .RVALID(RVALID),
           .RREADY(RREADY),
           .RLAST(RLAST),
           .RDATA(RDATA),
           .RD_last(RD_last),
           .RRESP(RRESP),
           .RBUSY(RBUSY)
           );

   //wr_buff
   assign               WREADY = (~wcmd_timeout) & (~wcmd_empty) & (~WBUSY) & WVALID;
   assign               WR     = WVALID & WREADY & (~wcmd_empty);
   assign               DIN    = WDATA;
   assign               BSEL   = WSTRB;
   
   
endmodule




