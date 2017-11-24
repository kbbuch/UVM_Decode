//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface UVM monitor
// File            : decode_out_monitor.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class receives decode_out transactions observed by the
//     decode_out monitor BFM and broadcasts them through the analysis port
//     on the agent. It accesses the monitor BFM through the monitor
//     task. This UVM component captures transactions
//     for viewing in the waveform viewer if the
//     enable_transaction_viewing flag is set in the configuration.
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
class decode_out_monitor extends uvmf_monitor_base #(
                    .CONFIG_T(decode_out_configuration ),
                    .BFM_BIND_T(virtual decode_out_monitor_bfm ),
                    .TRANS_T(decode_out_transaction ));

  `uvm_component_utils( decode_out_monitor )

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
   virtual function void configure(input CONFIG_T cfg);
      bfm.configure(

          cfg.active_passive,
          cfg.initiator_responder
);                    
   
   endfunction

// ****************************************************************************
   virtual function void set_bfm_proxy_handle();
      bfm.proxy = this;
   endfunction

 // ****************************************************************************              
  virtual task run_phase(uvm_phase phase);                                                   
  // Start monitor BFM thread and don't call super.run() in order to                       
  // override the default monitor proxy 'pull' behavior with the more                      
  // emulation-friendly BFM 'push' approach using the notify_transaction                   
  // function below                                                                        
  bfm.start_monitoring();                                                   
  endtask                                                                                    
  
  // ****************************************************************************              
  virtual function void notify_transaction(
                        input bit [5:0] E_Control,  
                        input bit Mem_Control,  
                        input bit [1:0] W_Control,  
                        input bit [15:0] IR,  
                        input bit [15:0] npc_out 
                        );
    trans = new("trans");                                                                   
    trans.start_time = time_stamp;                                                          
    trans.end_time = $time;                                                                 
    time_stamp = trans.end_time;                                                            
    trans.E_Control = E_Control;
    trans.Mem_Control = Mem_Control;
    trans.W_Control = W_Control;
    trans.IR = IR;
    trans.npc_out = npc_out;
    analyze(trans);                                                                         
  endfunction  

endclass
