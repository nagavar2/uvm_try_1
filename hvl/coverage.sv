import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class coverage extends uvm_subscriber #(sequence_transactions);
`uvm_component_utils(coverage)

bit [3:0] a,b;
bit [1:0] op;

covergroup inputs_alu; 
        all_ops : coverpoint op {
            bins or_ = {2'b00};
            bins and_ = {2'b01};
            bins xor_ = {2'b10};
            bins ones = {2'b11};
        }

        a_operand : coverpoint a{
            bins small_a = {[0:4]};
            bins medium_a = {[5:9]};
            bins big_a = {[10:15]};
        }

        b_operand : coverpoint b{
            bins small_b = {[0:4]};
            bins medium_b = {[5:9]};
            bins big_b = {[10:15]};
        }
endgroup

function new (string name, uvm_component parent);
    super.new(name, parent);
    inputs_alu = new(); //new for every cover group
endfunction

function void write (sequence_transactions t);    
    a = t.operandA;
    b = t.operandB;
    op = t.op; 
    `uvm_info("COVERAGE",$sformatf("a:%b\tb:%b\top:%b",a,b,op),UVM_HIGH)
    inputs_alu.sample();
endfunction

endclass