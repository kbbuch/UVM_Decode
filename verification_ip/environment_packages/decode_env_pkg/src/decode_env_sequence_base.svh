//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Nov 03
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode Environment 
// Unit            : Environment Sequence Base
// File            : decode_env_sequence_base.svh
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains environment level sequences that will
//    be reused from block to top level simulations.
//
//----------------------------------------------------------------------
//
class decode_env_sequence_base extends uvmf_sequence_base #(uvm_sequence_item);

  `uvm_object_utils( decode_env_sequence_base );

  function new(string name = "" );
    super.new(name);
  endfunction

endclass

