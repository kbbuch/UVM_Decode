//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_in interface agent
// Unit            : Interface Monitor BFM
// File            : decode_in_monitor_bfm.sv
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the decode_in signal monitoring.
//      It is accessed by the uvm decode_in monitor through a virtual
//      interface handle in the decode_in configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type decode_in_if.
//
//     Input signals from the decode_in_if are assigned to an internal input
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
//                   blocks until an operation on the decode_in bus is complete.
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import decode_in_pkg_hdl::*;

interface decode_in_monitor_bfm ( decode_in_if  bus );
// pragma attribute decode_in_monitor_bfm partition_interface_xif                                  
// The above pragma and additional ones in-lined below are for running this BFM on Veloce


   tri        clock_i;
   tri        reset_i;
   tri         enable_decode_i;
   tri        [15:0] dout_i;
   tri        [15:0] npc_in_i;

   assign     clock_i    =   bus.clock;
   assign     reset_i    =   bus.reset;
   assign     enable_decode_i = bus.enable_decode;
   assign     dout_i = bus.dout;
   assign     npc_in_i = bus.npc_in;

   // Proxy handle to UVM monitor
   decode_in_pkg::decode_in_monitor  proxy;
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
        bit [15:0] dout;
        bit enable_decode;
        bit [15:0] npc_in;
        @(posedge clock_i);                                                                   

        do_monitor(
                   dout,
                   enable_decode,
                   npc_in                  );
        if (enable_decode == 1)
		begin
		proxy.notify_transaction(
                   dout,
                   enable_decode,
                   npc_in                                ); 
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
                   output bit [15:0] dout,
                   output bit enable_decode,
                   output bit [15:0] npc_in                    );
// UVMF_CHANGE_ME : Implement protocol monitoring.
// Reference code;
		//@(posedge clock_i);
		
		dout = dout_i;
		enable_decode = enable_decode_i;
		npc_in = npc_in_i;

     endtask         
  
endinterface
