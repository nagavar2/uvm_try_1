package alu_pkg;
    import uvm_pkg::*;
    `include "sequence_item.sv"
    typedef uvm_sequencer #(sequence_transactions) sequencer;
    `include "uvm_macros.svh"
    
    `include "sequence_random.sv"
    `include "sequence_or.sv"
    `include "seq_run.sv"

    
    
    
    `include "result_transaction.sv"
    `include "scoreboard.sv"
    `include "driver.sv"
    `include "coverage.sv"
    `include "passive_monitor.sv"
    `include "active_monitor.sv"
    

    `include "environment.sv"
    `include "test_base.sv"
    `include "full_test.sv"
endpackage

    