class decode_monitor extends uvm_monitor;
`uvm_component_utils(decode_monitor)

    decode_seq_item trans;
    

    protected time time_stamp = 0;
    int transaction_viewing_stream;
 
    
    virtual decode_monitor_bfm bfm;
    
    uvm_analysis_port #(decode_seq_item) item_collected_port;
    
    virtual function void set_bfm_proxy_handle();
        bfm.proxy = this;
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // if(!uvm_config_db#(virtual decode_monitor_bfm)::get(this, "", "bfm", bfm))
            // `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
        set_bfm_proxy_handle();
	//item_collected_port = new("item_collected_port", this);
    endfunction: build_phase
	
    
    // Constructor
    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
        trans = new();
        item_collected_port = new("item_collected_port", this);
    endfunction : new
        
    virtual function void analyze(decode_seq_item trans);
        trans.add_to_wave(transaction_viewing_stream);
        `uvm_info("MONITOR_PROXY",trans.convert2string(),UVM_HIGH);
    endfunction
    
    virtual function void notify_transaction (
        input logic enable_decode,
        input logic [15:0] dout,
        input logic [15:0] npc_in
        );
        
        trans = new("trans");
        trans.enable_decode = enable_decode;
        trans.dout = dout;
        trans.npc_in = npc_in;

        trans.start_time = time_stamp;
        trans.end_time = $time;
        time_stamp = trans.end_time;
	item_collected_port.write(trans);
	$display("Transaction viewing related transfer done");
        analyze(trans);

    endfunction
    
    virtual function void start_of_simulation_phase(uvm_phase phase);
        transaction_viewing_stream = $create_transaction_stream({"..",get_full_name(),".","txn_stream"});

    endfunction
    
    
    virtual task run_phase(uvm_phase phase);
	->bfm.go;
        
    endtask : run_phase
    
endclass
