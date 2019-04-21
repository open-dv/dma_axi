
`uvm_analysis_imp_decl(_req_clr)

class dma_perf_collector extends uvm_scoreboard;
    `uvm_component_utils(dma_perf_collector)

    dma_perf_item dma_perf_item_h;    

    // analysis port declaration
    uvm_analysis_imp_req_clr#(dma_req_clr_item, dma_perf_collector)     req_clr_port;   


    // constructor function
    function new(string name="dma_perf_collector", uvm_component parent);
        super.new(name, parent);
        // create analysis ports
        req_clr_port = new("req_clr_port", this);
    endfunction: new
    
    // build_phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
		dma_perf_item_h = dma_perf_item::type_id::create("dma_perf_item_h");
    endfunction: build_phase
    
    // connect_phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase
    
    // run_phase
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

    endtask: run_phase
    
    // driver to scoreboard write function
    function void write_req_clr(dma_req_clr_item item);
        // print seq_item details received from driver
        `uvm_info("perf collector", $sformatf("Seq_item written from monitor: \n"), UVM_HIGH)
        item.print();
		dma_perf_item_h.total_tx_transfers++;
		dma_perf_item_h.total_tx_cycles = dma_perf_item_h.total_tx_cycles + item.req2clr_cycles;
		dma_perf_item_h.average_tx_cycles = dma_perf_item_h.total_tx_cycles/dma_perf_item_h.total_tx_transfers;		
    endfunction: write_req_clr
    
	// connect_phase
    virtual function void check_phase(uvm_phase phase);
        super.check_phase(phase);
		//dma_perf_item_h.print();
		$display("\n\n-----------------DMA Performance Report-------------------\n");
		$display("Total TX Transfers: %0d",dma_perf_item_h.total_tx_transfers);
		$display("Total TX Cycles:    %0d",dma_perf_item_h.total_tx_cycles);
		$display("Average TX Cycles:  %0d\n",dma_perf_item_h.average_tx_cycles);
    endfunction: check_phase
	
endclass: dma_perf_collector