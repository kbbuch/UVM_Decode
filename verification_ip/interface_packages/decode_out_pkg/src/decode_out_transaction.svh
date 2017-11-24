//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_out interface agent
// Unit            : Interface Transaction
// File            : decode_out_transaction.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an decode_out
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//
class decode_out_transaction extends uvmf_transaction_base;

  `uvm_object_utils( decode_out_transaction )

  bit [5:0] E_Control;
  bit Mem_Control;
  bit [1:0] W_Control;
  bit [15:0] IR;
  bit [15:0] npc_out;

//Constraints for the transaction variables:



// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "" );
    super.new( name );
 
  endfunction

// ****************************************************************************
// FUNCTION: convert2string()
// This function converts all variables in this class to a single string for 
// logfile reporting.
//
  virtual function string convert2string();
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("E_Control:0x%x Mem_Control:0x%x W_Control:0x%x IR:0x%x npc_out:0x%x ",E_Control,Mem_Control,W_Control,IR,npc_out);
  endfunction

//*******************************************************************
// FUNCTION: do_print()
// This function is automatically called when the .print() function
// is called on this class.
//
  virtual function void do_print(uvm_printer printer);
    if (printer.knobs.sprint==0)
      $display(convert2string());
    else
      printer.m_string = convert2string();
  endfunction

//*******************************************************************
// FUNCTION: do_compare()
// This function is automatically called when the .compare() function
// is called on this class.
//
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    decode_out_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
// UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.E_Control == RHS.E_Control)
            &&(this.Mem_Control == RHS.Mem_Control)
            &&(this.W_Control == RHS.W_Control)
            &&(this.IR == RHS.IR)
            &&(this.npc_out == RHS.npc_out)
            );
  endfunction

// ****************************************************************************
// FUNCTION: add_to_wave()
// This function is used to display variables in this class in the waveform 
// viewer.  The start_time and end_time variables must be set before this 
// function is called.  If the start_time and end_time variables are not set
// the transaction will be hidden at 0ns on the waveform display.
// 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    if (transaction_view_h == 0)
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_out_transaction",start_time);
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    super.add_to_wave(transaction_view_h);
// UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,E_Control,"E_Control");
    $add_attribute(transaction_view_h,Mem_Control,"Mem_Control");
    $add_attribute(transaction_view_h,W_Control,"W_Control");
    $add_attribute(transaction_view_h,IR,"IR");
    $add_attribute(transaction_view_h,npc_out,"npc_out");
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
  endfunction

endclass
