
interface dma_perf_interface(input clk);   

	logic              periph_tx_req;
    logic              periph_tx_clr;
    logic              periph_rx_req;
    logic              periph_rx_clr;
   
    logic [64/8-1:0]           WSTRB0;
    logic                      WVALID0;
    logic                      WREADY0;
   
    logic                      RVALID0;
    logic                      RREADY0;
   
   
   
    
   
endinterface : dma_perf_interface