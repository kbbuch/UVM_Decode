class decode_sequencer extends uvm_sequencer#(decode_seq_item);
 
   `uvm_sequencer_utils(decode_sequencer)
      
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
endclass : decode_sequencer