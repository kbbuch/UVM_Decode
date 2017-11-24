//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface Driver BFM
// File            : decode_out_driver_bfm.sv
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the decode_out signal driving.  It is
//     accessed by the uvm decode_out driver through a virtual interface
//     handle in the decode_out configuration.  It drives the singals passed
//     in through the port connection named bus of type decode_out_if.
//
//     Input signals from the decode_out_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within decode_out_if based on INITIATOR/RESPONDER and/or
//     ARBITRATION/GRANT status.  
//
//     The output signal connections are as follows:
//        signal_o -> bus.signal
//
//                                                                                           
//      Interface functions and tasks used by UVM components:                                
//             configure(uvmf_initiator_responder_t mst_slv);                                       
//                   This function gets configuration attributes from the                    
//                   UVM driver to set any required BFM configuration                        
//                   variables such as 'initiator_responder'.                                       
//                                                                                           
//             access(
//       bit [5:0] E_Control,
//       bit Mem_Control,
//       bit [1:0] W_Control,
//       bit [15:0] IR,
//       bit [15:0] npc_out );//                   );
//                   This task receives transaction attributes from the                      
//                   UVM driver and then executes the corresponding                          
//                   bus operation on the bus. 
//
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import decode_out_pkg_hdl::*;

interface decode_out_driver_bfm (decode_out_if  bus);
// pragma attribute decode_out_driver_bfm partition_interface_xif
// The above pragma and additional ones in-lined below are for running this BFM on Veloce

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;

  tri        clock_i;
  tri        reset_i;

// Signal list (all signals are capable of being inputs and outputs for the sake
// of supporting both INITIATOR and RESPONDER mode operation. Expectation is that 
// directionality in the config file was from the point-of-view of the INITIATOR

// INITIATOR mode input signals
  tri       [5:0]  E_Control_i;
  bit       [5:0]  E_Control_o;
  tri         Mem_Control_i;
  bit         Mem_Control_o;
  tri       [1:0]  W_Control_i;
  bit       [1:0]  W_Control_o;
  tri       [15:0]  IR_i;
  bit       [15:0]  IR_o;
  tri       [15:0]  npc_out_i;
  bit       [15:0]  npc_out_o;

// INITIATOR mode output signals

// Bi-directional signals
  

  /*assign     clock_i    =   bus.clock;
  assign     reset_i    =   bus.reset;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)
  assign     E_Control_i = bus.E_Control;
  assign     bus.E_Control = (initiator_responder == RESPONDER) ? E_Control_o : 'bz;
  assign     Mem_Control_i = bus.Mem_Control;
  assign     bus.Mem_Control = (initiator_responder == RESPONDER) ? Mem_Control_o : 'bz;
  assign     W_Control_i = bus.W_Control;
  assign     bus.W_Control = (initiator_responder == RESPONDER) ? W_Control_o : 'bz;
  assign     IR_i = bus.IR;
  assign     bus.IR = (initiator_responder == RESPONDER) ? IR_o : 'bz;
  assign     npc_out_i = bus.npc_out;
  assign     bus.npc_out = (initiator_responder == RESPONDER) ? npc_out_o : 'bz;
*/

  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.

   // Proxy handle to UVM driver
   decode_out_pkg::decode_out_driver  proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

//******************************************************************                         
   function void configure(
          uvmf_active_passive_t active_passive,
          uvmf_initiator_responder_t   init_resp
); // pragma tbx xtf                   
      initiator_responder = init_resp;
   
   endfunction                                                                               


// ****************************************************************************
  task do_transfer(                input bit [5:0] E_Control,
                input bit Mem_Control,
                input bit [1:0] W_Control,
                input bit [15:0] IR,
                input bit [15:0] npc_out               );                                                  
  // UVMF_CHANGE_ME : Implement protocol signaling.
  // Transfers are protocol specific and therefore not generated by the templates.
  // Use the following as examples of transferring data between a sequence and the bus
  // In the wb_pkg - wb_master_access_sequence.svh, wb_driver_bfm.sv
  // Reference code;
  //    while (control_signal == 1'b1) @(posedge clock_i);
  //    INITIATOR mode input signals
  //    E_Control_i;        //   [5:0] 
  //    E_Control_o <= xyz; //   [5:0]  
  //    Mem_Control_i;        //    
  //    Mem_Control_o <= xyz; //     
  //    W_Control_i;        //   [1:0] 
  //    W_Control_o <= xyz; //   [1:0]  
  //    IR_i;        //   [15:0] 
  //    IR_o <= xyz; //   [15:0]  
  //    npc_out_i;        //   [15:0] 
  //    npc_out_o <= xyz; //   [15:0]  
  //    INITIATOR mode output signals
  //    Bi-directional signals
 

  @(posedge clock_i);
  @(posedge clock_i);
  @(posedge clock_i);
  @(posedge clock_i);
  @(posedge clock_i);
  $display("decode_out_driver_bfm: Inside do_transfer()");
endtask        

  // UVMF_CHANGE_ME : Implement response protocol signaling.
  // Templates also do not generate protocol specific response signaling. Use the 
  // following as examples for transferring data between a sequence and the bus
  // In wb_pkg - wb_memory_slave_sequence.svh, wb_driver_bfm.sv

  task do_response(                 output bit [5:0] E_Control,
                 output bit Mem_Control,
                 output bit [1:0] W_Control,
                 output bit [15:0] IR,
                 output bit [15:0] npc_out       );
    @(posedge clock_i);
    @(posedge clock_i);
    @(posedge clock_i);
    @(posedge clock_i);
    @(posedge clock_i);
  endtask

  // The resp_ready bit is intended to act as a simple event scheduler and does
  // not have anything to do with the protocol. It is intended to be set by
  // a proxy call to do_response_ready() and ultimately cleared somewhere within the always
  // block below.  In this simple situation, resp_ready will be cleared on the
  // clock cycle immediately following it being set.  In a more complex protocol,
  // the resp_ready signal could be an input to an explicit FSM to properly
  // time the responses to transactions.  
  bit resp_ready;
  always @(posedge clock_i) begin
    if (resp_ready) begin
      resp_ready <= 1'b0;
    end
  end

  function void do_response_ready(    );  // pragma tbx xtf
    // UVMF_CHANGE_ME : Implement response - drive BFM outputs based on the arguments
    // passed into this function.  IMPORTANT - Must not consume time (it must remain
    // a function)
    resp_ready <= 1'b1;
  endfunction

// ****************************************************************************              
// UVMF_CHANGE_ME : Note that all transaction variables are passed into the access
//   task as inputs.  Some of these may need to be changed to outputs based on
//   protocol needs.
//
  task access(
    input   bit [5:0] E_Control,
    input   bit Mem_Control,
    input   bit [1:0] W_Control,
    input   bit [15:0] IR,
    input   bit [15:0] npc_out );
  // pragma tbx xtf                    
  @(posedge clock_i);                                                                     
  $display("decode_out_driver_bfm: Inside access()");
  do_transfer(
    E_Control,
    Mem_Control,
    W_Control,
    IR,
    npc_out          );                                                  
  endtask      

// ****************************************************************************              
// UVMF_CHANGE_ME : Note that all transaction variables are passed into the response
//   task as outputs.  Some of these may need to be changed to inputs based on
//   protocol needs.
  task response(
 output bit [5:0] E_Control,
 output bit Mem_Control,
 output bit [1:0] W_Control,
 output bit [15:0] IR,
 output bit [15:0] npc_out );
  // pragma tbx xtf
     @(posedge clock_i);
     $display("decode_out_driver_bfm: Inside response()");
    do_response(
      E_Control,
      Mem_Control,
      W_Control,
      IR,
      npc_out        );
  endtask             

endinterface
