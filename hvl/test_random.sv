import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class test_random extends test_base;

    `uvm_component_utils(test_random);
    seq_run_random seq_run_i;

    task run_phase(uvm_phase phase);
        seq_run_i = new("seq_run_i");
        phase.raise_objection(this);
        seq_run_i.start(null);
        phase.drop_objection(this);
    endtask

    function new (string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass

