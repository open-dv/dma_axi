class apb_directed_reg_write_read_test extends apb_base_test;
    `uvm_component_utils(apb_directed_reg_write_read_test)

    // constructor function
    function new(string name="apb_directed_reg_write_read_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction: new
    
    // build_phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase
    
    // connect_phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase
    
    // run_phase
    virtual task run_phase(uvm_phase phase);
        int mid_data_val = (2**`DATA_WIDTH)/4;
        int mid_high_data_val = 2*(2**`DATA_WIDTH)/4;
        int high_data_val = 3*(2**`DATA_WIDTH)/4;
        
        super.run_phase(phase);        
        phase.raise_objection(this);
            wr_data_2_mem('h1048, 1'b1, 0, 0); // CH start
			wr_data_2_mem('h10, 'h84032008, 0, 0); // Static 0
			wr_data_2_mem('h14, 'hC4032008, 0, 0); // Static 1
			wr_data_2_mem('h20, 'h10001, 0, 0); // Static 1
			wr_data_2_mem('h08, 'hF, 0, 0); // CMD2
			wr_data_2_mem('h0C, 'h2, 0, 0); // CMD3
			wr_data_2_mem('h40, 'h1, 0, 0); // CH Enable 
			wr_data_2_mem('h44, 'h1, 0, 0); // CH Start
			#2000ns;
        phase.drop_objection(this);
    endtask: run_phase
    
endclass: apb_directed_reg_write_read_test