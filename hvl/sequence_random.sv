import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class sequence_random extends uvm_sequence #(sequence_transactions);

    `uvm_object_utils(sequence_random);

    sequence_transactions cmd;

    function new(string name = "sequence_random");
        super.new(name);
    endfunction


    task body();
        repeat(10) begin
            cmd = sequence_transactions::type_id::create("cmd");
            start_item(cmd);
            assert(cmd.randomize());
            finish_item(cmd);
        end
    endtask

endclass