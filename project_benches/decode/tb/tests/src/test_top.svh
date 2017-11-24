import decode_env_pkg::*;

class test_top extends uvm_test;
 
  `uvm_component_utils(test_top)
  
  
  decode_env_configuration env_config;
  decode_environment env;

  decode_in_random_sequence seq;
  
  uvmf_sim_level_t sim_level = BLOCK; 
  string environment_path = "*";
  string interface_names[2] = {"in_bfm","out_bfm"};
	//interface_names [0] = "in_bfm";
	//interface_names [1] = "out_bfm";
  uvm_reg_block register_model = null;
  uvmf_active_passive_t interface_activity[2] = {ACTIVE,PASSIVE};
			//interface_activity[0] = "ACTIVE";
			//interface_activity[1] = "PASSIVE";
       
  function new(string name = "test_top",uvm_component parent=null);
	super.new(name,parent);	
  endfunction : new
 
  function void build_phase(uvm_phase phase);
    
	super.build_phase(phase); 
    
	
	env = decode_environment::type_id::create("env",this);
	$display($time, "env created");
	seq = decode_in_random_sequence::type_id::create("sequencer",this);
	env_config = new("decode_env_config");//decode_env_config::type_id::create("env_config",this);
	
	
	env_config.initialize(sim_level, 
                          environment_path,
                          interface_names,
                          null,
                          interface_activity
                          );
	$display($time, "Entered build phase of top");
    
  endfunction : build_phase
 
  task run_phase(uvm_phase phase);
  
	$display($time, "Entered run phase of top");
    phase.raise_objection(this);
	env.de_sb.enable_wait_for_scoreboard_empty();
	env_config.agent_in_config.wait_for_reset();
    repeat(25) 
		seq.start(env.agent_in.sequencer);
	env_config.agent_out_config.wait_for_num_clocks(1);
	env_config.agent_in_config.disable_decode();
	//env_config.agent_out_config.wait_for_num_clocks(2);
    phase.drop_objection(this);
  
  endtask : run_phase
 
endclass : test_top
