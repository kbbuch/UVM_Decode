class decode_seq_item extends uvm_sequence_item;
    //data and control fields  
    rand logic        enable_decode;
    //rand logic  [2:0] psr;
    typedef struct packed{
        logic [3:0] 	opcode;
        logic [2:0]	dest_reg;
        logic [2:0]	sr1;
        logic 		inst_type;
        logic [4:0]	sr2_or_imm5;
    }inst_out;
    rand inst_out dout;
    rand logic [15:0] npc_in;
    
    

    time start_time;
    time end_time;
    int transaction_view_h=0;


    //Utility and Field macros,
    `uvm_object_utils_begin(decode_seq_item)
        `uvm_field_int(enable_decode,UVM_ALL_ON)
        `uvm_field_int(dout,UVM_ALL_ON)
        `uvm_field_int(npc_in,UVM_ALL_ON)
	`uvm_field_int(start_time,UVM_ALL_ON)
        `uvm_field_int(end_time,UVM_ALL_ON)
    `uvm_object_utils_end
   
    //Constructor
    function new(string name = "decode_seq_item");
        super.new(name);
    endfunction
    
    constraint legal_opcodes {
		!(dout.opcode inside {4'd4,4'd8,4'd13,4'd15});
    }	

    constraint legal_dest {
        if (dout.opcode == 4'd0) {
            dout.dest_reg != 3'd0;
        }
        if (dout.opcode == 4'd12) {
            dout.dest_reg == 3'd0;
        }
    }

    constraint legal_sr2_or_imm5 {
        if (dout.opcode == 4'd9) {
            dout.inst_type == 1'b1;
            dout.sr2_or_imm5 == 5'b11111;
        }
        if (dout.opcode == 4'd12) {
            dout.inst_type == 1'b0;
            dout.sr2_or_imm5 == 5'b00000;
        }
        if (((dout.opcode == 4'd1) || (dout.opcode == 4'd5)) && (dout.inst_type == 1'b0)) {
            dout.sr2_or_imm5 < 5'b01000;
        }

    }
   virtual function void add_to_wave(int transaction_viewing_stream_h);
        if (transaction_view_h == 0)
        	transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_seq_item",start_time);
        $add_attribute(transaction_view_h,enable_decode,"enable_decode");
        $add_attribute(transaction_view_h,dout,"dout");
        $add_attribute(transaction_view_h,npc_in,"npc_in");
        $end_transaction(transaction_view_h,end_time);
        $free_transaction(transaction_view_h);
    endfunction
    
 

   
endclass
