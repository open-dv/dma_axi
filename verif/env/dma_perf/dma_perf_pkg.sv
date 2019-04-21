
package dma_perf_pkg;
    // include and import uvm_pkg
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    `include "tb_defines.sv"
    
    // typedefines
    typedef enum {REQ=0, DONE=1} item_type_t;
    
	`include "dma_req_clr_item.sv"
	`include "dma_perf_item.sv"
	`include "dma_perf_monitor.sv"
	`include "dma_perf_collector.sv"
endpackage: dma_perf_pkg