//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface Signal Bundle
// File            : decode_out_if.sv
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the decode_out interface signals.
//      It is instantiated once per decode_out bus.  Bus Functional Models, 
//      BFM's named decode_out_driver_bfm, are used to drive signals on the bus.
//      BFM's named decode_out_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(decode_out_bus.E_Control), // Agent input 
// .dut_signal_port(decode_out_bus.Mem_Control), // Agent input 
// .dut_signal_port(decode_out_bus.W_Control), // Agent input 
// .dut_signal_port(decode_out_bus.IR), // Agent input 
// .dut_signal_port(decode_out_bus.npc_out), // Agent input 

import uvmf_base_pkg_hdl::*;
import decode_out_pkg_hdl::*;

interface  decode_out_if  ( 
  input tri clock, 
  input tri reset
  ,inout tri [5:0] E_Control
  ,inout tri  Mem_Control
  ,inout tri [1:0] W_Control
  ,inout tri [15:0] IR
  ,inout tri [15:0] npc_out
  , inout tri enable_decode
);

endinterface

