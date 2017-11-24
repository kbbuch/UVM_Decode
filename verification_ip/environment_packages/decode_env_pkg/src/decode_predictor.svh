//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Nov 03
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_predictor 
// Unit            : decode_predictor 
// File            : decode_predictor.svh
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   analysis_export receives transactions of type  decode_in_transaction  
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  decode_predictor_ap broadcasts transactions of type decode_out_transaction 
//

import lc3_prediction_pkg::*;

class decode_predictor 
extends uvm_component;

  // Factory registration of this class
  `uvm_component_utils( decode_predictor );


  // Instantiate a handle to the configuration of the environment in which this component resides
  decode_env_configuration  configuration;

  // Instantiate the analysis exports
  uvm_analysis_imp_analysis_export #(decode_in_transaction, decode_predictor ) analysis_export;

  // Instantiate the analysis ports
  uvm_analysis_port #(decode_out_transaction) decode_predictor_ap;

  // Transaction variable for predicted values to be sent out decode_predictor_ap
  decode_out_transaction decode_predictor_ap_output_transaction;
  // Code for sending output transaction out through decode_predictor_ap
  // decode_predictor_ap.write(decode_predictor_ap_output_transaction);

	bit a;
	bit [2:0] psr;
	
  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);

    analysis_export = new("analysis_export", this);

    decode_predictor_ap =new("decode_predictor_ap", this );

  endfunction

  // FUNCTION: write_analysis_export
  // Transactions received through analysis_export initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_analysis_export(decode_in_transaction t);
    `uvm_info("COV", "Transaction Received through analysis_export", UVM_MEDIUM)
    `uvm_info("COV", {"            Data: ",t.convert2string()}, UVM_FULL)
/*
    `uvm_info("RED_ALERT:UNIMPLEMENTED_PREDICTOR_MODEL", "******************************************************************************************************",UVM_NONE)
    `uvm_info("RED_ALERT:UNIMPLEMENTED_PREDICTOR_MODEL", "The decode_predictor::write_analysis_export function needs to be completed with DUT prediction model",UVM_NONE)
    `uvm_info("RED_ALERT:UNIMPLEMENTED_PREDICTOR_MODEL", "******************************************************************************************************",UVM_NONE)
*/
	 // Construct one of each output transaction type.
  decode_predictor_ap_output_transaction = decode_out_transaction::type_id::create("decode_predictor_ap_output_transaction");
  
  a = decode_model(t.dout, psr, t.npc_in, decode_predictor_ap_output_transaction.IR, decode_predictor_ap_output_transaction.npc_out, 
					decode_predictor_ap_output_transaction.E_Control, decode_predictor_ap_output_transaction.W_Control, decode_predictor_ap_output_transaction.Mem_Control);

    // Code for sending output transaction out through decode_predictor_ap
    decode_predictor_ap.write(decode_predictor_ap_output_transaction);
  endfunction

endclass 

