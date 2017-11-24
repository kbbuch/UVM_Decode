class decode_agent extends uvm_agent;
  //declaring agent components
  decode_driver     driv;
  decode_sequencer  seq;
  decode_monitor    mon;
  decode_coverage   coverage;
  decode_config     config_debug;
 
  // UVM automation macros for general components
  `uvm_component_utils(decode_agent)
 
  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
 
    if(get_is_active() == UVM_ACTIVE) begin
      driv = decode_driver::type_id::create("driv", this);
      seq = decode_sequencer::type_id::create("seq", this);
      
    	if(!uvm_config_db#(decode_config)::get(this, "", "decode_config", config_debug))
        	`uvm_fatal("NO_decode_config",{"decode_config must be set for: ",get_full_name(),".decode_config"});
     
	$display("Entered Build phase of Agent");   
      
    end

    mon = decode_monitor::type_id::create("mon", this);
    coverage = decode_coverage::type_id::create("coverage", this);
    //config_debug = decode_config::type_id::create("config", this);
    driv.bfm = config_debug.driver_bfm;
    mon.bfm = config_debug.monitor_bfm;
    
  endfunction : build_phase
 
  // connect_phase
  function void connect_phase(uvm_phase phase);
	$display("Entered Connect phase of Agent"); 
    if(get_is_active() == UVM_ACTIVE) begin
      driv.seq_item_port.connect(seq.seq_item_export);
    end
    mon.item_collected_port.connect(coverage.analysis_export);
  endfunction : connect_phase
 
endclass : decode_agent
