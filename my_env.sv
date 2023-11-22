class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  my_agent agent;
  my_subscriber subscriber;
  my_scoreboard scoreboard;
  virtual intf my_vif;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = my_agent::type_id::create("agent", this);
    subscriber = my_subscriber::type_id::create("subscriber", this);
    scoreboard = my_scoreboard::type_id::create("scoreboard", this);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")
    uvm_config_db#(virtual intf)::set(this, "agent", "my_vif", my_vif);
    
      $display("env build phase");
  endfunction
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    
    agent.my_analysis_port.connect(scoreboard.my_analysis_export);
    agent.my_analysis_port.connect(subscriber.analysis_export);
    
    $display("env connect phase");
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("env run phase");
  endtask
  function void extract_phase (uvm_phase phase);
    super.extract_phase(phase);
    $display("env extract phase");
  endfunction
endclass
