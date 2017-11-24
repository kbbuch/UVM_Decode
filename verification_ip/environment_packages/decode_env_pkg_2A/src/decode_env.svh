class decode_env extends uvm_env;

	`uvm_component_utils(decode_env)
	
	decode_in_agent agent_in;
	decode_out_agent agent_out;
	
	decode_scoreboard de_sb;
	decode_predictor de_pred;
	
	function new (string name = "decode_env", uvm_component parent=null);
		super.new(name,parent);
	endfunction
		
	virtual function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);
		
		agent_in = decode_in_agent::type_id::create("agent_in", this);
		agent_out = decode_out_agent::type_id::create("agent_out", this);
		de_sb = decode_scoreboard::type_id::create("scoreboard",this);
		de_pred = decode_predictor::type_id::create("predictor",this);
		
		$display($time, "Entered build_phase of env");
	endfunction : build_phase
	
	virtual function void connect_phase(uvm_phase phase);
		uvm_top.print_topology();
		$display($time, "Entered connect_phase of env");
		agent_in.monitored_ap.connect(de_pred.analysis_export);
		
		$display($time, "connected agent to pred");
		de_pred.decode_predictor_ap.connect(de_sb.expected_analysis_export);
		
		$display($time, "connected pred to sb");
		agent_out.monitored_ap.connect(de_sb.actual_analysis_export);
	
		$display($time, "Connected ALL!");
	endfunction : connect_phase

endclass: decode_env