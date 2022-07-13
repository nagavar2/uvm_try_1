import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class passive_monitor extends uvm_component;

`uvm_component_utils(passive_monitor);

virtual alu_bfm bfm;
uvm_analysis_port #(sequence_transactions) ap;
//uvm_put_port #(sequence_transactions) pp;
//uvm_tlm_analysis_fifo #(sequence_transactions) cmd_f;

function new (string name, uvm_component parent);
    super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(virtual alu_bfm) :: get(null,"*","bfm",bfm))
        `uvm_fatal("DRIVER", "Failed to get BFM")

    ap = new("ap",this);
    //pp = new ("pp", this);

endfunction

function void connect_phase (uvm_phase phase);
    bfm.passive_monitor_h = this;
endfunction

function void write_to_monitor(bit [3:0] A, B,
                                bit [1:0] opcode);
    sequence_transactions cmd;
    `uvm_info ("PASSIVE MONITOR", $sformatf("PASSIVE MONITOR A:%b\tB:%b\tOP:%b",A,B,opcode),UVM_HIGH);
    cmd = new("cmd");
    cmd.operandA = A;
    cmd.operandB = B;
    cmd.op = opcode;
    ap.write(cmd);
    //pp.write(cmd);
    //cmd_f.try_put(cmd);
endfunction

endclass