//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Nov 03
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode Environment 
// Unit            : decode Environment
// File            : decode_environment.svh
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//----------------------------------------------------------------------
//



class decode_environment 
extends uvmf_environment_base #(.CONFIG_T( decode_env_configuration
                             ));

  `uvm_component_utils( decode_environment );





  typedef decode_in_agent agent_in_agent_t;
  agent_in_agent_t agent_in;

  typedef decode_out_agent agent_out_agent_t;
  agent_out_agent_t agent_out;


  typedef decode_predictor  de_pred_t;
  de_pred_t de_pred;

  typedef uvmf_in_order_race_scoreboard #(decode_out_transaction)  de_sb_t;
  de_sb_t de_sb;



// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent_in = agent_in_agent_t::type_id::create("agent_in",this);
    agent_out = agent_out_agent_t::type_id::create("agent_out",this);
    de_pred = de_pred_t::type_id::create("de_pred",this);
    de_pred.configuration = configuration;
    de_sb = de_sb_t::type_id::create("de_sb",this);


  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
	//uvm_top.print_topology();
    agent_in.monitored_ap.connect(de_pred.analysis_export);
    de_pred.decode_predictor_ap.connect(de_sb.expected_analysis_export);
    agent_out.monitored_ap.connect(de_sb.actual_analysis_export);

uvm_top.print_topology();
  endfunction

endclass

