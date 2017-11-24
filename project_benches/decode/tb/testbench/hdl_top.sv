 `include "../../../../verification_ip/interface_packages/decode_in_pkg/src/decode_in_driver_bfm.sv"
 `include "../../../../verification_ip/interface_packages/decode_in_pkg/src/decode_in_monitor_bfm.sv"
 
module hdl_top;
  
    import decode_test_pkg::*;
    import uvm_pkg::*;
	import decode_env_pkg::*;
	`include "uvm_macros.svh"
  
//clock and reset signal declaration
  logic clk;
  logic reset;
  
  tri  enable_decode;
  logic enable_decode_out;
  tri [15:0] dout;
  tri [15:0] npc_in;
  
  tri [5:0] E_Control;
  tri  Mem_Control;
  tri [1:0] W_Control;
  tri [15:0] IR;
  tri [15:0] npc_out;
  
  always@(posedge clk)
	enable_decode_out = bus_in.enable_decode;
	
	assign bus_out.enable_decode = enable_decode_out;
    
	//creating instance of interface, inorder to connect DUT and testcase
  decode_in_if bus_in(clk,reset,enable_decode,dout,npc_in);
  decode_in_driver_bfm monitor_in_bfm(bus_in);
  decode_in_monitor_bfm driver_in_bfm(bus_in);
  
  decode_out_if bus_out(clk,reset,E_Control,Mem_Control,W_Control,IR,npc_out);
  decode_out_monitor_bfm monitor_out_bfm(bus_out);
  decode_out_driver_bfm driver_out_bfm(bus_out);
  
  initial begin
      uvm_config_db#(virtual decode_in_driver_bfm) :: set(null, "*", "in_bfm", monitor_in_bfm);
      uvm_config_db#(virtual decode_in_monitor_bfm) :: set(null, "*", "in_bfm", driver_in_bfm);
	  
      uvm_config_db#(virtual decode_out_monitor_bfm) :: set(null, "*", "out_bfm", monitor_out_bfm);
      uvm_config_db#(virtual decode_out_driver_bfm) :: set(null, "*", "out_bfm", driver_out_bfm);
  end
   
  //reset Generation
  initial begin
    reset = 1;
    #10 reset =0;
  end
  
  initial begin
  clk = 1;
  end
   
  //clock generation
  always #5 clk = ~clk; 
  
   Decode DUT (
    .clock(clk),
    .reset(reset),
    .enable_decode(bus_in.enable_decode),
    .dout(bus_in.dout),
    .npc_in(bus_in.npc_in),

    .W_Control(bus_out.W_Control),
    .Mem_Control(bus_out.Mem_Control),
    .E_Control(bus_out.E_Control),
    .IR(bus_out.IR),
    .npc_out(bus_out.npc_out)
   );
  //enabling the wave dump
  // initial begin
    // uvm_config_db#(virtual mem_if)::set(uvm_root::get(),"*","mem_intf",intf);
    // $dumpfile("dump.vcd"); $dumpvars;
  // end
   
endmodule
