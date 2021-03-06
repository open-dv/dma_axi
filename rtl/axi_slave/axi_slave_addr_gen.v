//------------------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- RobustVerilog version 1.2 (limited free version)
//-- Invoked Sun Mar 24 15:39:38 2019
//-- Source file: axi_slave_addr_gen.v
//-- Parent file: axi_slave_ram.v
//-- Run directory: E:/vlsi/axi_slave/run/
//-- Target directory: out/
//-- Command flags: ../src/base/axi_slave.v -od out -I ../src/gen -list list.txt -listpath -header -gui 
//-- www.provartec.com/edatools ... info@provartec.com
//------------------------------------------------------------------






module axi_slave_addr_gen(clk,reset,cmd_addr,cmd_size,advance,restart,ADDR);
   
   input               clk;
   input               reset;

   input [32-1:0]      cmd_addr;
   input [2-1:0]       cmd_size;

   input               advance;
   input               restart;

   output [32-1:0]     ADDR;

   
   reg [32-1:0]           offset;
   wire [3:0]               size_bytes;              

   assign               size_bytes =
                  cmd_size == 2'b00 ? 4'd1 :
                  cmd_size == 2'b01 ? 4'd2 :
                  cmd_size == 2'b10 ? 4'd4 :
                  cmd_size == 2'b11 ? 4'd8 : 4'd0;
   
   always @(posedge clk or posedge reset)
     if (reset)
       offset <= #1 {32{1'b0}};
     else if (restart)
       offset <= #1 {32{1'b0}};
     else if (advance)
       offset <= #1 offset + size_bytes;

   assign               ADDR = cmd_addr + offset;


endmodule

   


