///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// File Name: apb_reset_test.sv
// Author: Farshad
// Email: farshad112@gmail.com
// Revision: 0.1
// Description: power on reset test. Read the default value of the RAM after power on reset.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class apb_reset_test extends apb_base_test;
    `uvm_component_utils(apb_reset_test)

    // constructor function
    function new(string name="apb_reset_test", uvm_component parent=null);
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
        $display("reset started");
        super.run_phase(phase);        
        phase.raise_objection(this);
            reset_dut();
        phase.drop_objection(this);
        $display("reset ended");
	endtask: run_phase
    
endclass: apb_reset_test