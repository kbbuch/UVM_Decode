import lc3_prediction_pkg::*;

class decode_predictor extends uvm_subscriber #(decode_in_transaction);
	
	`uvm_component_utils(decode_predictor)
	
	uvm_analysis_port #(decode_out_transaction) decode_predictor_ap;
	
	decode_out_transaction trans_out;
	bit a;
	bit [2:0] psr;
	
	function new (string name = "decode_predictor", uvm_component parent);
		super.new(name,parent);	
		decode_predictor_ap = new("decode_predictor_ap",this);
	endfunction
	
	virtual function void write (decode_in_transaction t);
		
		trans_out = new();
		a = decode_model(t.dout, psr, t.npc_in, trans_out.IR, trans_out.npc_out, 
					trans_out.E_Control, trans_out.W_Control, trans_out.Mem_Control);
		decode_predictor_ap.write (trans_out);
		
	endfunction
	
endclass : decode_predictor