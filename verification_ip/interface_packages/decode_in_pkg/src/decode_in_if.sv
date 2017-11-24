//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_in interface agent
// Unit            : Interface Signal Bundle
// File            : decode_in_if.sv
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the decode_in interface signals.
//      It is instantiated once per decode_in bus.  Bus Functional Models, 
//      BFM's named decode_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named decode_in_monitor_bfm are used to monitor signals on the 
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
// .dut_signal_port(decode_in_bus.enable_decode), // Agent output 
// .dut_signal_port(decode_in_bus.dout), // Agent output 
// .dut_signal_port(decode_in_bus.npc_in), // Agent output 

import uvmf_base_pkg_hdl::*;
import decode_in_pkg_hdl::*;

interface  decode_in_if  ( 
  input tri clock, 
  input tri reset
  ,inout tri  enable_decode
  ,inout tri [15:0] dout
  ,inout tri [15:0] npc_in
);

endinterface

