//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface HVL package
// File            : decode_out_pkg.sv
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    interface package that will run on the host simulator.
//
// CONTAINS:
//    - <decode_out_typedefs_hdl>
//    - <decode_out_typedefs.svh>
//    - <decode_out_transaction.svh>

//    - <decode_out_configuration.svh>
//    - <decode_out_driver.svh>
//    - <decode_out_monitor.svh>

//    - <decode_out_transaction_coverage.svh>
//    - <decode_out_sequence_base.svh>
//    - <decode_out_random_sequence.svh>

//    - <decode_out_responder_sequence.svh>
//    - <decode_out2reg_adapter.svh>
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
package decode_out_pkg;
  
   import uvm_pkg::*;
   import questa_uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import decode_out_pkg_hdl::*;
   `include "uvm_macros.svh"
   
   export decode_out_pkg_hdl::*;
   
 
   `include "src/decode_out_typedefs.svh"
   `include "src/decode_out_transaction.svh"

   `include "src/decode_out_configuration.svh"
   `include "src/decode_out_driver.svh"
   `include "src/decode_out_monitor.svh"

   `include "src/decode_out_transaction_coverage.svh"
   `include "src/decode_out_sequence_base.svh"
   `include "src/decode_out_random_sequence.svh"

   `include "src/decode_out_responder_sequence.svh"
   `include "src/decode_out2reg_adapter.svh"

   `include "src/decode_out_agent.svh"

   typedef uvm_reg_predictor #(decode_out_transaction) decode_out2reg_predictor;


endpackage

