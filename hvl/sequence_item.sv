import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class sequence_transactions extends uvm_sequence_item;

    `uvm_object_utils(sequence_transactions);
    rand bit [3:0] operandA;
    rand bit [3:0] operandB;
    rand bit [1:0] op;
    bit [3:0] result;
    bit done;

    function string convert2string();
        string s;
        s = $sformatf("OperandA:%h\t OperandB:%h\t op:%h",operandA,operandB,op);
        return s;
    endfunction 

 function new (string name = "");
        super.new(name);
    endfunction

    constraint operands {operandA <=15;
                            operandA >=0;
                            operandB <=15;
                            operandB >0;}
    constraint opcode {op <=3;
                        op >=0;}
                        
    
endclass