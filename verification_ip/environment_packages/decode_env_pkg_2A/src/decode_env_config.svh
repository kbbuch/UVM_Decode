import uvmf_base_pkg::*;

class decode_env_config extends uvm_object;

	//`uvm_object_utils(decode_env_config,)
	
	decode_in_configuration in_agent_config;
	decode_out_configuration out_agent_config;
	
	function new (string name = "decode_env_config");
		
		super.new(name);
		
		in_agent_config = decode_in_configuration::type_id::create("config_in"); //bfr agent
		out_agent_config = decode_out_configuration::type_id::create("config_out"); 
		
	endfunction
	
	virtual function void initialize(uvmf_active_passive_t activity_in_agent,
									string agent_path_in,
									string name_in,
									uvmf_active_passive_t activity_out_agent,
									string agent_path_out,
									string name_out);
		
		in_agent_config.initialize(activity_in_agent,agent_path_in,name_in);
		out_agent_config.initialize(activity_out_agent,agent_path_out,name_out);
		
	endfunction	
	
endclass: decode_env_config