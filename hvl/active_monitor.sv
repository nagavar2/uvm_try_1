import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class active_monitor extends uvm_component;

`uvm_component_utils(active_monitor);

virtual alu_bfm bfm;
uvm_analysis_port #(result_transaction) ap;

function new (string name, uvm_component parent);
    super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(virtual alu_bfm) :: get(null,"*","bfm",bfm))
        `uvm_fatal("DRIVER", "Failed to get BFM")

    ap = new("ap",this);

endfunction

function void connect_phase (uvm_phase phase);
    bfm.active_monitor_h = this;
endfunction

function void write_to_monitor(bit [3:0] r,d);
    result_transaction result_t;
    `uvm_info ("ACTIVE MONITOR", $sformatf("ACTIVE MONITOR Result:%b done:%b",r,d),UVM_HIGH);
    result_t = new("result_t");
    result_t.result = r;
    result_t.done = d;
    ap.write(result_t);
endfunction

endclass