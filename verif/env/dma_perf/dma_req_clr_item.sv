class dma_req_clr_item extends uvm_sequence_item;
    item_type_t item_type_h;
	int unsigned req2clr_cycles;      // Address

    // constructor function
    function new(string name="dma_req_clr_item");
        super.new(name);
    endfunction: new
    
    // register fields with uvm_factory
    `uvm_object_utils_begin(dma_req_clr_item)
        `uvm_field_int(req2clr_cycles, UVM_ALL_ON)
        `uvm_field_enum(item_type_t, item_type_h, UVM_ALL_ON)
    `uvm_object_utils_end
    
endclass : dma_req_clr_item