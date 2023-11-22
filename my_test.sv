class my_test extends uvm_test;
  `uvm_component_utils(my_test)
  my_env env;
  virtual intf my_vif;
  my_sequence sequence_inst;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = my_env::type_id::create("env", this);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")
      uvm_config_db#(virtual intf)::set(this, "env", "my_vif", my_vif);
    
    sequence_inst = my_sequence::type_id::create("sequence_inst");
    $display("test build phase");
  endfunction
  
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    $display("test connect phase");
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("test run phase");
    phase.raise_objection(this);
    sequence_inst.start(env.agent.sequencer);
    phase.drop_objection(this);
  endtask
  
  function void extract_phase (uvm_phase phase);
    super.extract_phase(phase);
    $display("test extract phase");
  endfunction
endclass : my_test
