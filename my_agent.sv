class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent)
  my_driver driver;
  my_monitor monitor;
  my_sequencer sequencer;
  virtual intf my_vif;
  uvm_analysis_port#(my_sequence_item) my_analysis_port;
  
  function new(string name = "my_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver = my_driver::type_id::create("driver", this);
    monitor = my_monitor::type_id::create("monitor", this);
    sequencer = my_sequencer::type_id::create("sequencer", this);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")
    uvm_config_db#(virtual intf)::set(this, "driver", "my_vif", my_vif);
    uvm_config_db#(virtual intf)::set(this, "monitor", "my_vif", my_vif);
    
    my_analysis_port = new("my_analysis_port", this);
      $display("agent build phase");
  endfunction
  function void connect_phase(uvm_phase phase);
  	super.connect_phase(phase);
    monitor.my_analysis_port.connect(my_analysis_port);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    $display("agent connect phase");
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("agent run phase");
  endtask
  function void extract_phase (uvm_phase phase);
    super.extract_phase(phase);
    $display("agent extract phase");
  endfunction
endclass
