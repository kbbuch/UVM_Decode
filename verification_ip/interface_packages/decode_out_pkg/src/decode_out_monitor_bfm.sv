//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface Monitor BFM
// File            : decode_out_monitor_bfm.sv
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the decode_out signal monitoring.
//      It is accessed by the uvm decode_out monitor through a virtual
//      interface handle in the decode_out configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type decode_out_if.
//
//     Input signals from the decode_out_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the decode_out bus is complete.
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import decode_out_pkg_hdl::*;

interface decode_out_monitor_bfm ( decode_out_if  bus );
// pragma attribute decode_out_monitor_bfm partition_interface_xif                                  
// The above pragma and additional ones in-lined below are for running this BFM on Veloce


   tri        clock_i;
   tri        reset_i;
   tri        [5:0] E_Control_i;
   tri         Mem_Control_i;
   tri        [1:0] W_Control_i;
   tri        [15:0] IR_i;
   tri        [15:0] npc_out_i;
   tri 			enable_decode;

   assign     clock_i    =   bus.clock;
   assign     reset_i    =   bus.reset;
   assign     E_Control_i = bus.E_Control;
   assign     Mem_Control_i = bus.Mem_Control;
   assign     W_Control_i = bus.W_Control;
   assign     IR_i = bus.IR;
   assign     npc_out_i = bus.npc_out;
   assign 	  enable_decode = bus.enable_decode;

   // Proxy handle to UVM monitor
   decode_out_pkg::decode_out_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

//******************************************************************                         
   task wait_for_reset(); // pragma tbx xtf                                                  
      //@(posedge clock_i) ;                                                                    
      do_wait_for_reset();                                                                   
   endtask                                                                                   

// ****************************************************************************              
   task do_wait_for_reset();                                                                 
      wait ( reset_i == 0 ) ;                                                              
      @(posedge clock_i) ;                                                                    
   endtask    
   
//******************************************************************                         
   task wait_for_num_clocks( input int unsigned count); // pragma tbx xtf                           
      @(posedge clock_i);                                                                     
      repeat (count-1) @(posedge clock_i);                                                    
   endtask      

//******************************************************************                         
  event go;                                                                                 
  function void start_monitoring(); // pragma tbx xtf      
     -> go;                                                                                 
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
     @go;                                                                                   
     forever begin                                                                          
        bit [5:0] E_Control;
        bit Mem_Control;
        bit [1:0] W_Control;
        bit [15:0] IR;
        bit [15:0] npc_out;
        //@(posedge clock_i);                                                                   

        do_monitor(
                   E_Control,
                   Mem_Control,
                   W_Control,
                   IR,
                   npc_out				   );
		if(enable_decode == 1)
		begin
			proxy.notify_transaction(
                   E_Control,
                   Mem_Control,
                   W_Control,
                   IR,
                   npc_out                                );
		end
     end                                                                                    
  end                                                                                       

//******************************************************************
   function void configure(
          uvmf_active_passive_t active_passive,
          uvmf_initiator_responder_t   initiator_responder
); // pragma tbx xtf

   endfunction


// ****************************************************************************              
     task do_monitor(
                   output bit [5:0] E_Control,
                   output bit Mem_Control,
                   output bit [1:0] W_Control,
                   output bit [15:0] IR,
                   output bit [15:0] npc_out                    );
// UVMF_CHANGE_ME : Implement protocol monitoring.
// Reference code;
	 @(posedge clock_i);
	 E_Control = E_Control_i;
	 Mem_Control = Mem_Control_i;
	 W_Control = W_Control_i;
	 IR = IR_i;
	 npc_out = npc_out_i;


     endtask         
  
endinterface
