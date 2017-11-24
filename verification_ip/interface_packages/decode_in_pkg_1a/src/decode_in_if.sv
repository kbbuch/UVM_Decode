interface decode_if(
				
						input logic			decode_reset,
						input logic			decode_clock
					
						);
                        
        logic			decode_enable_decode;

        logic	[15:0]	decode_dout;
        logic	[15:0]	decode_npc_in;

endinterface
