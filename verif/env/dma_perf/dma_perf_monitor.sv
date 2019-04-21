class dma_perf_monitor extends uvm_monitor;
    `uvm_component_utils(dma_perf_monitor)
    
    // virtual interface instance
    virtual dma_perf_interface dma_perf_intf;
    
    // analysis port instance
    uvm_analysis_port#(dma_req_clr_item)   req_clr_analysis_port;         // analysis port to be connected with scoreboard
    
    // constructor function
    function new(string name="dma_perf_monitor", uvm_component parent);
        super.new(name, parent);
        
        // create analysis port
        req_clr_analysis_port = new("req_clr_analysis_port", this);

    endfunction: new 
    
    // build_phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
		 // get the interface from uvm_config_db
        if(!uvm_config_db#(virtual dma_perf_interface)::get(this,"","DMA_PERF_INTF", dma_perf_intf)) begin
            `uvm_fatal("INTERFACE NOT FOUND ERROR", $sformatf("Could not retrieve dma_perf_interface from uvm_config_db"))
        end
    endfunction: build_phase
    
    // connect_phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase
    
    // run_phase
    virtual task run_phase(uvm_phase phase);
      dma_req_clr_item req_clr_item;
	  int unsigned req2clr_cycles;
	  super.run_phase(phase); 
      forever begin
        req2clr_cycles = 0;
		if(dma_perf_intf.periph_tx_req) begin
		    req_clr_item = dma_req_clr_item::type_id::create("req_clr_item");
			while(!(dma_perf_intf.periph_tx_req & dma_perf_intf.periph_tx_clr)) begin
				req2clr_cycles++;
				@(dma_perf_intf.clk);
				#1;
		    end
			req_clr_item.req2clr_cycles = req2clr_cycles;
			req_clr_item.item_type_h = DONE;
			req_clr_analysis_port.write(req_clr_item);
			`uvm_info("PERF Monitor", 
				$sformatf("req2clr_cycles=%0d",req2clr_cycles), UVM_NONE)
		end
		@(dma_perf_intf.clk);
		@(dma_perf_intf.clk);
	  end 
	 
    endtask: run_phase
endclass: dma_perf_monitor