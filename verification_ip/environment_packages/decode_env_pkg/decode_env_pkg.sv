//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Nov 03
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode environment agent
// Unit            : Environment HVL package
// File            : decode_pkg.sv
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    environment package that will run on the host simulator.
//
// CONTAINS:
//     - <decode_configuration.svh>
//     - <decode_environment.svh>
//     - <decode_env_sequence_base.svh>
//     - <decode_infact_env_sequence.svh>
//     - <decode_predictor.svh>
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
package decode_env_pkg;

   import uvm_pkg::*;
   import questa_uvm_pkg::*;
   `include "uvm_macros.svh"

   import uvmf_base_pkg::*;
   import decode_in_pkg::*;
   import decode_out_pkg::*;




 

   `uvm_analysis_imp_decl(_analysis_export)

   `include "src/decode_env_typedefs.svh"

   `include "src/decode_env_configuration.svh"
   `include "src/decode_predictor.svh"
   `include "src/decode_environment.svh"
   `include "src/decode_env_sequence_base.svh"
   `include "src/decode_infact_env_sequence.svh"
  
endpackage

