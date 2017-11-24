//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_in interface agent
// Unit            : Interface random sequence
// File            : decode_in_random_sequence.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the decode_in transaction and sends it 
// to the UVM driver.
//
// ****************************************************************************
// This sequence constructs and randomizes a decode_in_transaction.
// 
class decode_in_random_sequence extends decode_in_sequence_base ;

  `uvm_object_utils(decode_in_random_sequence)

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
	  //repeat(25)
	  //begin
		  /*------------------------
		  
		    req _temp=decode_in_transaction::type_id::create("req");
		    if(sent_local == 1'b1 || start == 1'b1)
			begin
				  req=decode_in_transaction::type_id::create("req");

				  start_item(req);
				  // Randomize the transaction
				  if(!req.randomize()) `uvm_fatal("SEQ", "decode_in_random_sequence::body()-decode_in_transaction randomization failed")
				  // Send the transaction to the decode_in_driver_bfm via the sequencer and decode_in_driver.
				  finish_item(req);
				  `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)
				  
				  
				  if(txn.sent == 1'b0)
				  begin
				    sent_local = txn.sent;
					req_temp=req.copy(); //------deep copy
				  end
			end
			else
			begin
				  start_item(req_temp);
				  // Randomize the transaction
				  //if(!req.randomize()) `uvm_fatal("SEQ", "decode_in_random_sequence::body()-decode_in_transaction randomization failed")
				  // Send the transaction to the decode_in_driver_bfm via the sequencer and decode_in_driver.
				  finish_item(req_temp);
				  `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)
				  
			end
			------------------------*/
		  req=decode_in_transaction::type_id::create("req");

		  start_item(req);
		  // Randomize the transaction
		  if(!req.randomize()) `uvm_fatal("SEQ", "decode_in_random_sequence::body()-decode_in_transaction randomization failed")
		  // Send the transaction to the decode_in_driver_bfm via the sequencer and decode_in_driver.
		  finish_item(req);
		  `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)
		  
	  //end
	end

  endtask: body

endclass: decode_in_random_sequence
//----------------------------------------------------------------------
//
