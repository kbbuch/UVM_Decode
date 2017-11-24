# Makefile for use with ECE792-036 Project 2B
#
export UVMF_VIP_LIBRARY_HOME ?= ../../../verification_ip

include $(UVMF_HOME)/scripts/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/decode_in_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/interface_packages/decode_out_pkg/Makefile
include $(UVMF_VIP_LIBRARY_HOME)/environment_packages/decode_env_pkg/Makefile

comp_lc3_prediction_pkg:
	vlog -sv +incdir+../../../verification_ip/environment_packages/decode_env_pkg \
../../../verification_ip/environment_packages/decode_env_pkg/lc3_prediction_pkg.sv	

comp_decode_test_pkg:	
	vlog -sv +incdir+../tb/tests ../tb/tests/decode_test_pkg.sv

comp_test_bench:
	vlog -sv ../tb/testbench/hdl_top.sv ../tb/testbench/hvl_top.sv
	vlog ../rtl/verilog/data_defs.vp ../rtl/verilog/data_defs_decode.vp ../rtl/verilog/Decode_Pipelined.vp

debug3:  comp_fli_pkg comp_uvmf_base_pkg comp_decode_in_pkg comp_decode_out_pkg comp_lc3_prediction_pkg comp_decode_env_pkg comp_decode_test_pkg comp_test_bench
	vsim -sv_seed 1 +UVM_TESTNAME=test_top +UVM_VERBOSITY=UVM_HIGH +UVM_PHASE_TRACE +notimingchecks -suppress 8887 -uvmcontrol=all -msgmode both -classdebug -do " coverage save -onexit test_top.ucdb; set IterationLimit 140000; set NoQuitOnFinish 1; onbreak {resume}; " hdl_top hvl_top
