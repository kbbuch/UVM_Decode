module hvl_top();

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import decode_test_pkg::*;
    import decode_in_pkg::*;
	import decode_env_pkg::*;
    
  initial begin
	$display("run_test "); 
	run_test();
	#20;
  end

endmodule  
