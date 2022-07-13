compile:
	vlib work
	vmap work work
	vlog hvl/alu_pkg.sv
	vlog hdl/alu.sv
	vlog hdl/interface.sv
	vlog hvl/active_monitor.sv
	vlog hvl/passive_monitor.sv
	vlog hvl/driver.sv
	vlog hvl/environment.sv
	vlog hvl/full_test.sv
	vlog hvl/result_transaction.sv
	vlog hvl/scoreboard.sv
	vlog hvl/seq_run.sv
	vlog hvl/sequence_random.sv
	vlog hvl/sequencer.sv
	vlog hvl/test_base.sv
	vlog hvl/top.sv
run:compile
	vsim -c top +UVM_VERBOSITY=UVM_HIGH -do "run -all; quit"