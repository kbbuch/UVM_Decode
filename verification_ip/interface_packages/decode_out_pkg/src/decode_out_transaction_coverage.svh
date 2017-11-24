//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface Transaction Coverage
// File            : decode_out_transaction_coverage.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records decode_out transaction information using
//       a covergroup named decode_out_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
// ****************************************************************************
//----------------------------------------------------------------------
//
class decode_out_transaction_coverage extends uvm_subscriber #(.T(decode_out_transaction ));

  `uvm_component_utils( decode_out_transaction_coverage )

  bit [5:0] E_Control;
  bit Mem_Control;
  bit [1:0] W_Control;
  bit [15:0] IR;
  bit [15:0] npc_out;

// ****************************************************************************
  // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
  covergroup decode_out_transaction_cg;
    option.auto_bin_max=1024;
    coverpoint E_Control;
    coverpoint Mem_Control;
    coverpoint W_Control;
    coverpoint IR;
    coverpoint npc_out;
  endgroup

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    decode_out_transaction_cg=new;
    decode_out_transaction_cg.set_inst_name($sformatf("decode_out_transaction_cg_%s",get_full_name()));
 endfunction

// ****************************************************************************
// FUNCTION: write (T t)
// This function is automatically executed when a transaction arrives on the
// analysis_export.  It copies values from the variables in the transaction 
// to local variables used to collect functional coverage.  
//
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    E_Control = t.E_Control;
    Mem_Control = t.Mem_Control;
    W_Control = t.W_Control;
    IR = t.IR;
    npc_out = t.npc_out;
    decode_out_transaction_cg.sample();
  endfunction

endclass
