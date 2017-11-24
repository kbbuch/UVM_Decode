//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_in interface agent
// Unit            : Interface HVL package
// File            : decode_in_pkg.sv
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    interface package that will run on the host simulator.
//
// CONTAINS:
//    - <decode_in_typedefs_hdl>
//    - <decode_in_typedefs.svh>
//    - <decode_in_transaction.svh>

//    - <decode_in_configuration.svh>
//    - <decode_in_driver.svh>
//    - <decode_in_monitor.svh>

//    - <decode_in_transaction_coverage.svh>
//    - <decode_in_sequence_base.svh>
//    - <decode_in_random_sequence.svh>

//    - <decode_in_responder_sequence.svh>
//    - <decode_in2reg_adapter.svh>
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
package decode_in_pkg;
  
   import uvm_pkg::*;
   import questa_uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import decode_in_pkg_hdl::*;
   `include "uvm_macros.svh"
   
   export decode_in_pkg_hdl::*;
   
 
   `include "src/decode_in_typedefs.svh"
   `include "src/decode_in_transaction.svh"

   `include "src/decode_in_configuration.svh"
   `include "src/decode_in_driver.svh"
   `include "src/decode_in_monitor.svh"

   `include "src/decode_in_transaction_coverage.svh"
   `include "src/decode_in_sequence_base.svh"
   `include "src/decode_in_random_sequence.svh"

   `include "src/decode_in_responder_sequence.svh"
   `include "src/decode_in2reg_adapter.svh"

   `include "src/decode_in_agent.svh"

   typedef uvm_reg_predictor #(decode_in_transaction) decode_in2reg_predictor;

endpackage

