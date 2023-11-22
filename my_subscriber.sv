class my_subscriber extends uvm_subscriber#(my_sequence_item);
  `uvm_component_utils(my_subscriber)
  my_sequence_item item;
  covergroup group1;
  	coverpoint item.addr;  
  endgroup
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    group1 = new();
  endfunction
  
  function void write(my_sequence_item t);
    item = t;
    $display("subscriber data = %p", t.addr);
    group1.sample();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item = my_sequence_item::type_id::create("item");
      $display("subscriber build phase");
  endfunction
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    $display("subscriber connect phase");
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("subscriber run phase");
  endtask
  function void extract_phase (uvm_phase phase);
    super.extract_phase(phase);
    $display("subscriber extract phase");
  endfunction
endclass
