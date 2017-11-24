class decode_config extends uvm_component;
	
	`uvm_component_utils(decode_config)
    
    virtual decode_monitor_bfm monitor_bfm;
    
    virtual decode_driver_bfm driver_bfm;
    
    //constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction	

    function init();
        if(!uvm_config_db#(virtual decode_monitor_bfm)::get(this, "*", "mon_bfm", monitor_bfm))
        `uvm_fatal("NO decode_monitor_bfm",{"virtual interface must be set for: ",get_full_name(),".monitor_bfm"});

        if(!uvm_config_db#(virtual decode_driver_bfm)::get(this, "*", "drv_bfm", driver_bfm))
        `uvm_fatal("No_decode_driver_bfm",{"virtual interface must be set for: ",get_full_name(),".driver_bfm"});
        uvm_config_db#(decode_config)::set(null,"uvm_test_top.agent","decode_config",this);
    endfunction
	
endclass
