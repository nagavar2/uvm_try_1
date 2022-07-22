import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top;
    
    alu_bfm bfm();
    alu dut (.clk(bfm.clk),.resetn(bfm.resetn),.operandA(bfm.operandA),.operandB(bfm.operandB),.op(bfm.op),.result(bfm.result),.done(bfm.done));

    initial begin
        uvm_config_db #(virtual alu_bfm) :: set(null,"*","bfm",bfm);
        run_test();
    end
endmodule