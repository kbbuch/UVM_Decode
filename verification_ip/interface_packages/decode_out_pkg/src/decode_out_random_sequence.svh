//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface random sequence
// File            : decode_out_random_sequence.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the decode_out transaction and sends it 
// to the UVM driver.
//
// ****************************************************************************
// This sequence constructs and randomizes a decode_out_transaction.
// 
class decode_out_random_sequence extends decode_out_sequence_base ;

  `uvm_object_utils(decode_out_random_sequence)

//*****************************************************************
  function new(string name = "");
    super.new(name);
  endfunction: new

// ****************************************************************************
// TASK : body()
// This task is automatically executed when this sequence is started using the 
// start(sequencerHandle) task.
//
  task body();

    begin
      // Construct the transaction
      req=decode_out_transaction::type_id::create("req");

      start_item(req);
      // Randomize the transaction
      if(!req.randomize()) `uvm_fatal("SEQ", "decode_out_random_sequence::body()-decode_out_transaction randomization failed")
      // Send the transaction to the decode_out_driver_bfm via the sequencer and decode_out_driver.
      finish_item(req);
      `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)
    end

  endtask: body

endclass: decode_out_random_sequence
//----------------------------------------------------------------------
//
