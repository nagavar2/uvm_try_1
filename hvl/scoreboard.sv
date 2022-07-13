import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class scoreboard extends uvm_subscriber #(result_transaction);

    `uvm_component_utils(scoreboard);
    function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

    uvm_tlm_analysis_fifo #(sequence_transactions) cmd_f;
    //uvm_get_port #(sequence_transactions) gp;
   function void build_phase(uvm_phase phase);
      cmd_f = new ("cmd_f", this);
      //gp = new("gp",this);
   endfunction : build_phase

function result_transaction predict_result(sequence_transactions cmd);
   result_transaction predicted;
      
   predicted = new("predicted");
      
   case (cmd.op)
     2'b00: predicted.result = cmd.operandA | cmd.operandB;
     2'b01: predicted.result = cmd.operandA & cmd.operandB;
     2'b10: predicted.result = cmd.operandA ^ cmd.operandB;
     2'b11: predicted.result = '1;
     default: predicted.result = 0;
   endcase // case (op_set)

   return predicted;

endfunction : predict_result
   

   function void write(result_transaction t);
      string data_str;
      sequence_transactions cmd;
      result_transaction predicted;

      //do
       //  if (!gp.try_get(cmd))
       //  $fatal(1, "Missing command in self checker");
       //  else
      //while ((cmd.op == 0) || (cmd.op == 1) || (cmd.op == 2) || (cmd.op == 3));
      if (!cmd_f.try_get(cmd)) begin
         `uvm_info("SCOREBOARD","No cmd",UVM_HIGH);
         `uvm_info ("SCOREBOARD", $sformatf("FROM ARUG Result:%b done:%b",t.result,t.done),UVM_HIGH);
      end
      else begin
      predicted = predict_result(cmd);
      
      data_str = {                    cmd.convert2string(), 
                  " ==>  Actual "  ,    t.convert2string(), 
                  "/Predicted ",predicted.convert2string()};

      //`uvm_info("SELF CHECKER",{"CHECK:",data_str},UVM_NONE);
      
      if (!predicted.compare(t))
        `uvm_error("SELF CHECKER", {"FAIL: ",data_str})
        //$display("%s",data_str);
      else
        `uvm_info ("SELF CHECKER", {"PASS: ", data_str},UVM_HIGH)
      end
   endfunction : write
endclass : scoreboard