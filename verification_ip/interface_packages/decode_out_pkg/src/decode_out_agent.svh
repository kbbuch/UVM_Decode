//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface UVM agent
// File            : decode_out_agent.svh
//----------------------------------------------------------------------
//     
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
class decode_out_agent extends uvmf_parameterized_agent #(
                    .CONFIG_T(decode_out_configuration ),
                    .DRIVER_T(decode_out_driver ),
                    .MONITOR_T(decode_out_monitor ),
                    .COVERAGE_T(decode_out_transaction_coverage ),
                    .TRANS_T(decode_out_transaction )
                    );

  `uvm_component_utils( decode_out_agent )

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

endclass
