//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_in interface agent
// Unit            : Interface Sequence Base
// File            : decode_in_sequence_base.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This file contains the class used as the base class for all sequences
// for this interface.
//
// ****************************************************************************
// ****************************************************************************
class decode_in_sequence_base extends uvmf_sequence_base #(
                             .REQ(decode_in_transaction ),
                             .RSP(decode_in_transaction ));

  `uvm_object_utils( decode_in_sequence_base )

  // variables
  decode_in_transaction  req;
  decode_in_transaction  rsp;

// Event for identifying when a response was received from the sequencer
event new_rsp;
// ****************************************************************************
// TASK : get_responses()
// This task recursively gets sequence item responses from the sequencer.
//
virtual task get_responses();
   fork
      begin
         // Block until new rsp available
         get_response(rsp);
         // New rsp received.  Indicate to sequence using event.
         ->new_rsp;
         // Display the received response transaction
         `uvm_info("SEQ", {"New response transaction:",rsp.convert2string()}, UVM_MEDIUM)
      end
   join_none
endtask

// ****************************************************************************
// TASK : pre_body()
// This task is called automatically when start is called with call_pre_post set to 1 (default).
// By calling get_responses() within pre_body() any derived sequences are automatically 
// processing response transactions.
//
virtual task pre_body();
   get_responses();
endtask

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name ="");
    super.new( name );
  endfunction

endclass
//----------------------------------------------------------------------
//
