import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class seq_run_or extends uvm_sequence #(uvm_sequence_item);
    
    //typedef uvm_sequencer #(sequence_transactions) sequencer;
    `uvm_object_utils(seq_run_or);
    sequence_or or_seq;
    uvm_component uvm_component_h;
    sequencer sequencer_h;

    function new(string name = "seq_run_or");
        super.new(name);
        uvm_component_h = uvm_top.find("*.env_h.sequencer_h");

        if (uvm_component_h == null)
            `uvm_fatal("Seq_run","Failed to get the sequencer");

        if(!$cast(sequencer_h,uvm_component_h))
            `uvm_fatal("Seq_run","failed to cast from uvm_component_h");

         or_seq = sequence_or::type_id::create("or_seq");
    endfunction

    task body();
        or_seq.start(sequencer_h);
    endtask

endclass