//`include "../decode_in_pkg.sv"

interface decode_monitor_bfm (decode_if bus);

import decode_in_pkg::*;
	 decode_in_pkg::decode_monitor proxy;

    logic         reset;
    logic         clock;
    logic         enable_decode_t;
    logic [15:0]  dout_t;
    logic [15:0]  npc_in_t;

	event go;
    
    task do_monitor ();

        reset = bus.decode_reset;
       enable_decode_t = bus.decode_enable_decode;
        dout_t = bus.decode_dout;
        npc_in_t = bus.decode_npc_in;
    
    endtask 
    

    initial begin
    
        @go;
        forever begin
            logic         enable_decode;
            logic [15:0]  dout;
            logic [15:0]  npc_in;
            
            @(posedge bus.decode_clock);
		
            
            do_monitor();

            proxy.notify_transaction(
                enable_decode_t, 
                dout_t, 
                npc_in_t);
        end
    
    end
    
endinterface
