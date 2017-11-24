package decode_env_pkg;

	import uvm_pkg::*;
	import questa_uvm_pkg::*;
	import uvmf_base_pkg::*;
   
	import decode_in_pkg::*;
	import decode_out_pkg::*;
	
	`include "uvm_macros.svh"
	
   `include "src/decode_predictor.svh"
   `include "src/decode_scoreboard.svh"
   `include "src/decode_env.svh"
   `include "src/decode_env_config.svh"
   
endpackage