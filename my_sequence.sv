class my_sequence extends uvm_sequence;
  `uvm_object_utils(my_sequence)
  my_sequence_item seq_item_inst;
  
  function new(string name = "my_sequence");
    super.new(name);
  endfunction
  
  task pre_body;
    seq_item_inst = my_sequence_item::type_id::create("seq_item_inst");  
  endtask
  
  task body;
    $display("start of body task");
    // define 2 sequences both transmit 4 packets
    for(int i=0; i<16; i++) begin
    start_item(seq_item_inst);
      $display("start item has been invoked");
      seq_item_inst.rst = 1'b1;
      seq_item_inst.en = 1'b1;
      seq_item_inst.re = 1'b0;
    void'(seq_item_inst.randomize());
    finish_item(seq_item_inst);
      $display("finish item has been invoked");
    end
    for(int i=0; i<16;i++) begin
    start_item(seq_item_inst);
      $display("start item has been invoked");
      seq_item_inst.rst = 1'b1;
      seq_item_inst.en = 1'b0;
      seq_item_inst.re = 1'b1;
      void'(seq_item_inst.randomize());
    finish_item(seq_item_inst);
      $display("finish item has been invoked");
    end
  endtask
endclass