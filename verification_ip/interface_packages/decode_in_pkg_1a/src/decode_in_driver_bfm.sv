interface decode_driver_bfm (decode_if bus);

    
    task access(
        input logic enable_decode,
        input logic [15:0] dout,
        input logic [15:0] npc_in);
        
        do_transfer(
            enable_decode,
            dout,
            npc_in);
            
    endtask
    
    task do_transfer (
        input logic enable_decode,
        input logic [15:0] dout,
        input logic [15:0] npc_in);
        
        $display("Entered for driving signal");
        @(posedge (bus.decode_clock));
            bus.decode_enable_decode <= enable_decode; // made non-blocking for transaction viewing
            bus.decode_dout <= dout; // made non-blocking for transaction viewing
            bus.decode_npc_in <= npc_in; // made non-blocking for transaction viewing
        $display("Signal level transfer done!");
 
    endtask    
        
endinterface

