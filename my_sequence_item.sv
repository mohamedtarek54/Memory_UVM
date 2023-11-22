class my_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(my_sequence_item)
  function new (string name = "my_sequence_item");
    super.new(name);
  endfunction
  //rand logic clk;
  logic en, re, rst, valid_out;
  randc logic [3:0] addr;
  rand logic [31:0] data_in;
  logic [31:0] data_out;
endclass