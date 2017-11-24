class decode_coverage extends uvm_subscriber#(decode_seq_item);

	decode_seq_item trans;
    
    `uvm_component_utils(decode_coverage)
	
	covergroup decode_cover_group;
		enable_cover_group: coverpoint trans.enable_decode ;
		dout_cover_group: coverpoint trans.dout[15:12] 
		{
			bins ADD = {4'h1};
			bins AND = {4'h5};			
		}
		npc_in_cover_group: coverpoint trans.npc_in;
	endgroup: decode_cover_group;

    function new(string name, uvm_component parent);
        super.new(name,parent);
        decode_cover_group = new;
    endfunction: new

	function void write(decode_seq_item t);
		trans = t;
		decode_cover_group.sample();
	endfunction: write
    
endclass
