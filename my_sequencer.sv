class my_sequencer extends uvm_sequencer #(my_sequence_item);
  `uvm_component_utils(my_sequencer)
  my_sequence_item s_item;
  
  function new(string name = "my_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      $display("sequencer build phase");
  endfunction
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    $display("sequencer connect phase");
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("sequencer run phase");
  endtask
  function void extract_phase (uvm_phase phase);
    super.extract_phase(phase);
    $display("sequencer extract phase");
  endfunction
endclass
