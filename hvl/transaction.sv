//NOT NEEDED
//Refer sequencer.sv
class transaction extends uvm_transaction; 
    `uvm_object_utils(transaction)
    rand bit [3:0] operandA;
    rand bit [3:0] operandB;
    rand bit [1:0] op;
    //bit [3:0] result;

    function string convert2string();
        string s;
        s = $sformat("OperandA:%h\t OperandB:%h\t op:%h",operandA,operandB,op);
        return s;
    endfunction

    function new (string name="");
        super.new(name);
    endfunction 

endclass