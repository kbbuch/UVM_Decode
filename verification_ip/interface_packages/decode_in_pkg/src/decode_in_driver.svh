//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_in interface agent
// Unit            : Interface UVM Driver
// File            : decode_in_driver.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class passes transactions between the sequencer
//        and the BFM driver interface.  It accesses the driver BFM 
//        through the bfm handle. This driver
//        passes transactions to the driver BFM through the access
//        task.  
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
class decode_in_driver extends uvmf_driver_base #(
                   .CONFIG_T(decode_in_configuration ),
                   .BFM_BIND_T(virtual decode_in_driver_bfm),
                   .REQ(decode_in_transaction ),
                   .RSP(decode_in_transaction ));

  `uvm_component_utils( decode_in_driver )

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent=null );
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
  virtual task access( inout REQ txn );
      if (configuration.initiator_responder==RESPONDER) begin
        if (1'b1) begin
          bfm.do_response_ready(
                      );
        end
        bfm.response(
      txn.dout,
      txn.enable_decode,
      txn.npc_in        
          ); 
		  /*----------------------
		  if(txn.i_mem_rd === 1'b1)
		  begin
			bfm.access(txn.dout, txn.enable_decode,	txn.npc_in);
			txn.sent = 1'b1;
		  end
		  else
		  begin
			while(txn.sent != 1'b1) 
			begin
					bfm.response(
							  txn.dout,
							  txn.enable_decode,
							  txn.npc_in        
								  );
					if(txn.i_mem_rd === 1'b1)
					begin
						bfm.access(txn.dout, txn.enable_decode,	txn.npc_in);
						txn.sent = 1'b1;
					end
				end
			end
		  end	
		  -----------------------*/
      end else begin    
        bfm.access(
      txn.dout,
      txn.enable_decode,
      txn.npc_in            );
    end
  endtask

endclass
