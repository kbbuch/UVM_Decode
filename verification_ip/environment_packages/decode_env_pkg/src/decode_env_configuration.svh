//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Nov 03
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode Environment 
// Unit            : Environment configuration
// File            : decode_env_configuration.svh
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: THis is the configuration for the decode environment.
//  it contains configuration classes for each agent.  It also contains
//  environment level configuration variables.
//
//
//
//----------------------------------------------------------------------
//
class decode_env_configuration 
extends uvmf_environment_configuration_base;

  `uvm_object_utils( decode_env_configuration ); 


//Constraints for the configuration variables:


  covergroup decode_configuration_cg;
    option.auto_bin_max=1024;
  endgroup


    typedef decode_in_configuration agent_in_config_t;
    agent_in_config_t agent_in_config;

    typedef decode_out_configuration agent_out_config_t;
    agent_out_config_t agent_out_config;



// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
// This function constructs the configuration object for each agent in the environment.
//
  function new( string name = "" );
    super.new( name );


    agent_in_config = agent_in_config_t::type_id::create("agent_in_config");
    agent_out_config = agent_out_config_t::type_id::create("agent_out_config");


  endfunction

// ****************************************************************************
// FUNCTION: post_randomize()
// This function is automatically called after the randomize() function 
// is executed.
//
  function void post_randomize();
    super.post_randomize();


    if(!agent_in_config.randomize()) `uvm_fatal("RAND","agent_in randomization failed");
    if(!agent_out_config.randomize()) `uvm_fatal("RAND","agent_out randomization failed");

  endfunction
  
// ****************************************************************************
// FUNCTION: convert2string()
// This function converts all variables in this class to a single string for
// logfile reporting. This function concatenates the convert2string result for
// each agent configuration in this configuration class.
//
  virtual function string convert2string();
    return {
     
     "\n", agent_in_config.convert2string,
     "\n", agent_out_config.convert2string


       };

  endfunction
// ****************************************************************************
// FUNCTION: initialize();
// This function configures each interface agents configuration class.  The 
// sim level determines the active/passive state of the agent.  The environment_path
// identifies the hierarchy down to and including the instantiation name of the
// environment for this configuration class.  Each instance of the environment 
// has its own configuration class.  The string interface names are used by 
// the agent configurations to identify the virtual interface handle to pull from
// the uvm_config_db.  
//
  function void initialize(uvmf_sim_level_t sim_level, 
                                      string environment_path,
                                      string interface_names[],
                                      uvm_reg_block register_model = null,
                                      uvmf_active_passive_t interface_activity[] = null
                                     );


    super.initialize(sim_level, environment_path, interface_names, register_model, interface_activity);


     agent_in_config.initialize( interface_activity[0], {environment_path,".agent_in"}, interface_names[0]);
     agent_in_config.initiator_responder = INITIATOR;
     agent_out_config.initialize( interface_activity[1], {environment_path,".agent_out"}, interface_names[1]);
     //agent_out_config.initiator_responder = INITIATOR;





  endfunction

endclass

