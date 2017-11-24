//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Created by      : kbbuch
// Creation Date   : 2017 Oct 16
// Created with uvmf_gen version 3.6g
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
// Project         : decode_in interface agent
// Unit            : Interface Transaction
// File            : decode_in_transaction.svh
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an decode_in
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
// ****************************************************************************
// ****************************************************************************
//----------------------------------------------------------------------
//

class decode_in_transaction extends uvmf_transaction_base;

  `uvm_object_utils( decode_in_transaction )

  rand bit immediate;
  rand bit [3:0] opcode;
  rand bit [2:0] dest_reg;
  rand bit [4:0] imm5;
  rand bit [2:0] sr1;
  bit enable_decode;
  bit [15:0] dout;
  rand bit [15:0] npc_in;

//Constraints for the transaction variables:
    constraint op_constraints {
		(opcode inside {4'd2,4'd5,4'd6,4'd7,4'd9,4'd10,4'd11,4'd12,4'd14});
    }	

    constraint destination_constraints {
        if (opcode == 4'd0) {
            dest_reg != 3'd0;
        }
        if (opcode == 4'd12) {
            dest_reg == 3'd0;
        }
    }

    constraint constraint_mix {
        if (opcode == 4'd9) {
            immediate == 1'b1;
            imm5 == 5'b11111;
        }
        if (opcode == 4'd12) {
            immediate == 1'b0;
            imm5 == 5'b00000;
        }
        if (((opcode == 4'd1) || (opcode == 4'd5)) && (immediate == 1'b0)) {
            imm5 < 5'b01000;
        }
    }
    
    constraint npc_constraints { npc_in >= 16'h3000;}
// **************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "" );
    super.new( name );
 
  endfunction

// **************************
// FUNCTION: convert2string()
// This function converts all variables in this class to a single string for 
// logfile reporting.
//
  virtual function string convert2string();
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("immediate:0x%x op:0x%x sr1:0x%x dr:0x%x imm5:0x%x enable_decode:0x%x dout:0x%x npc_in:0x%x ",immediate,opcode,sr1,dest_reg,imm5,enable_decode,dout,npc_in);
  endfunction

//***********************
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

//***********************
// FUNCTION: do_compare()
// This function is automatically called when the .compare() function
// is called on this class.
//
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    decode_in_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
// UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.enable_decode == RHS.enable_decode)
            &&(this.dout == RHS.dout)
            &&(this.npc_in == RHS.npc_in)
            );
  endfunction

// **************************
// FUNCTION: add_to_wave()
// This function is used to display variables in this class in the waveform 
// viewer.  The start_time and end_time variables must be set before this 
// function is called.  If the start_time and end_time variables are not set
// the transaction will be hidden at 0ns on the waveform display.
// 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    if (transaction_view_h == 0)
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_in_transaction",start_time);
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    super.add_to_wave(transaction_view_h);
// UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,enable_decode,"enable_decode");
    $add_attribute(transaction_view_h,dout,"dout");
    $add_attribute(transaction_view_h,npc_in,"npc_in");
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
  endfunction

  function void post_randomize();
    
    dout = {opcode, dest_reg, sr1, immediate, imm5};
	$display("dout = %x, opcode = %x, dest_reg = %x, sr1 = %x, imm5 = %x, immediate = %x",dout, opcode, dest_reg, sr1, imm5, immediate);
    enable_decode = 1'b1;
    
  endfunction 
  
endclass