module top;
  import uvm_pkg::*;
  import memory_pkg::*;

  `include "uvm_macros.svh"

  intf intf1 ();
  memory_16x32 mem (intf1.clk, intf1.re, intf1.en, intf1.rst, intf1.addr, intf1.data_in, 
                    intf1.data_out, intf1.valid_out);

  
  initial 
    begin
      $dumpfile("dump.vcd"); $dumpvars(0, top);
      intf1.clk = 1'b0;
      uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "my_vif", intf1);
      run_test("my_test");
    end
endmodule