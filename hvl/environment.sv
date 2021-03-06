import alu_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class env extends uvm_env;

    `uvm_component_utils(env);
    sequencer      sequencer_h;
    coverage        coverage_h;
    scoreboard      scoreboard_h;
    driver          driver_h;
    passive_monitor passive_monitor_h;
    active_monitor  active_monitor_h;

    uvm_tlm_analysis_fifo #(sequence_transactions) cmd_f;

    function new (string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
    //stimilus generation and driving
    sequencer_h = new("sequencer_h",this);
    driver_h = driver::type_id::create("driver_h",this);

    //TESTING
    cmd_f = new ("cmd_f", this);

    //active & passive monitors
    passive_monitor_h = passive_monitor::type_id::create("passive_monitor_h",this);
    active_monitor_h = active_monitor::type_id::create("active_monitor_h",this);
    coverage_h = coverage::type_id::create("coverage_h",this);

    //scoreboard
    scoreboard_h = scoreboard::type_id::create("scoreboard_h",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        //from --------------------------to
        driver_h.seq_item_port.connect(sequencer_h.seq_item_export); // connecting driver with sequencer
        passive_monitor_h.ap.connect(scoreboard_h.cmd_f.analysis_export); //connecting passive monitor with scoreboard
        active_monitor_h.ap.connect(scoreboard_h.analysis_export); // connecting active monitor with scoreboard
        passive_monitor_h.ap.connect(coverage_h.analysis_export);
    endfunction


endclass