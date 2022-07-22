import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class driver extends uvm_driver #(sequence_transactions);

    `uvm_component_utils(driver);
    virtual alu_bfm bfm;

    function void build_phase (uvm_phase phase);
        if(!uvm_config_db #(virtual alu_bfm) :: get (null,"*","bfm",bfm))
        `uvm_fatal("DRIVER","failed to get BFM")
       
    endfunction


    task run_phase(uvm_phase phase);
    
    sequence_transactions cmd;
        forever begin
            bit [3:0] result;
            bit done;
            // Forcing reset signal
            bfm.resetn = 1;
            seq_item_port.get_next_item(cmd);
            bfm.send_op(cmd.operandA,cmd.operandB,cmd.op,result,done);
            cmd.result = result;
            cmd.done = done;
            seq_item_port.item_done();
        end
    endtask

    function new (string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass