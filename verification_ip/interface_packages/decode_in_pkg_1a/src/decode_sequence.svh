class decode_sequence extends uvm_sequence#(decode_seq_item);
   
  `uvm_object_utils(decode_sequence)
  
    
  //Constructor
  function new(string name = "decode_sequence");
    super.new(name);
    // if(!uvm_config_db#(decode_config)::get(this, "", "decode_config", config_debug))
        	// `uvm_fatal("NO_decode_config",{"decode_config must be set for: ",get_full_name(),".decode_config"});
  endfunction
   
  virtual task body();
 
    repeat(25) begin
        req = decode_seq_item::type_id::create("req");  //create the req (seq item)
        wait_for_grant();                            //wait for grant

        req.randomize();                     //randomize the req                   
        send_request(req);                           //send req to driver
        wait_for_item_done();                        //wait for item done from driver

    end
 
 
    #10;
    //@(posedge(config_debug.monitor_bfm.clock));
 
  endtask
endclass
