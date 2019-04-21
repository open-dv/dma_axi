class dma_perf_item extends uvm_sequence_item;
    int unsigned total_tx_transfers;
	int unsigned total_tx_cycles;
	int unsigned average_tx_cycles;

    // constructor function
    function new(string name="dma_perf_item");
        super.new(name);
    endfunction: new
    
    // register fields with uvm_factory
    `uvm_object_utils_begin(dma_perf_item)
        `uvm_field_int(total_tx_transfers, UVM_ALL_ON)
		`uvm_field_int(total_tx_cycles, UVM_ALL_ON)
		`uvm_field_int(average_tx_cycles, UVM_ALL_ON)
    `uvm_object_utils_end
    
endclass : dma_perf_item