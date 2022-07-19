compile:
	vlib work
	vmap work work
	vlog hvl/alu_pkg.sv
	vlog hdl/alu.sv
	vlog hdl/interface.sv
	vlog hvl/active_monitor.sv
	vlog hvl/passive_monitor.sv
	vlog hvl/driver.sv
	vlog hvl/coverage.sv
	vlog hvl/environment.sv
	vlog hvl/full_test.sv
	vlog hvl/result_transaction.sv
	vlog hvl/scoreboard.sv
	vlog hvl/seq_run.sv
	vlog hvl/sequence_item.sv
	vlog hvl/sequence_random.sv
	vlog hvl/sequence_or.sv
	vlog hvl/test_base.sv
	vlog hvl/top.sv
run:compile
	vsim -c -cvgperinstance top +UVM_VERBOSITY=UVM_HIGH -do "coverage save -onexit my_coverage.ucdb; run -all;exit"
	#vcover report -details my_coverage.ucdb 