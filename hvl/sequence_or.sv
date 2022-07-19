import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class sequence_or extends uvm_sequence #(sequence_transactions);

    `uvm_object_utils(sequence_or);

    sequence_transactions cmd;

    function new(string name = "sequence_or");
        super.new(name);
    endfunction


    task body();
    `uvm_info("OR_SEQUENCE",$sformatf("op: or only"),UVM_HIGH);
        repeat(10) begin
            cmd = sequence_transactions::type_id::create("cmd");
            start_item(cmd);
            assert(cmd.randomize() with {op == 0;});
            finish_item(cmd);
        end
    endtask

endclass