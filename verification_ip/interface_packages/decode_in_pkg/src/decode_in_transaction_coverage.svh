//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_in interface agent
// Unit            : Interface Transaction Coverage
// File            : decode_in_transaction_coverage.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records decode_in transaction information using
//       a covergroup named decode_in_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
// ****************************************************************************
//----------------------------------------------------------------------
//
class decode_in_transaction_coverage extends uvm_subscriber #(.T(decode_in_transaction ));

  `uvm_component_utils( decode_in_transaction_coverage )

  bit [15:0] dout;
  bit enable_decode;
  bit [15:0] npc_in;

// ****************************************************************************
  // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
  covergroup decode_in_transaction_cg;
    option.auto_bin_max=1024;
    coverpoint dout;
    coverpoint enable_decode;
    coverpoint npc_in;
  endgroup

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    decode_in_transaction_cg=new;
    decode_in_transaction_cg.set_inst_name($sformatf("decode_in_transaction_cg_%s",get_full_name()));
 endfunction

// ****************************************************************************
// FUNCTION: write (T t)
// This function is automatically executed when a transaction arrives on the
// analysis_export.  It copies values from the variables in the transaction 
// to local variables used to collect functional coverage.  
//
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    dout = t.dout;
    enable_decode = t.enable_decode;
    npc_in = t.npc_in;
    decode_in_transaction_cg.sample();
  endfunction

endclass
