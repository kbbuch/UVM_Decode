class decode_driver extends uvm_driver #(decode_seq_item);
`uvm_component_utils(decode_driver)

virtual decode_driver_bfm bfm;

    // Constructor
    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // if(!uvm_config_db#(virtual decode_driver_bfm)::get(this, "", "bfm", bfm))
    // `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    endfunction: build_phase
  
    // run phase
    virtual task run_phase(uvm_phase phase);
        repeat(25) begin
            seq_item_port.get_next_item(req);
            //respond_to_transfer(req);
            access(req);
            seq_item_port.item_done();
        end
    endtask : run_phase
  
    virtual task access (inout decode_seq_item decode_seq_item_handle);
        bfm.access(
            decode_seq_item_handle.enable_decode,
            decode_seq_item_handle.dout,
            decode_seq_item_handle.npc_in);
    endtask
    
endclass
