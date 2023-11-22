class my_driver extends uvm_driver#(my_sequence_item);
  `uvm_component_utils(my_driver)
  my_sequence_item s_item;
  virtual intf my_vif;
  
  function new(string name = "my_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif);
    
    $display("driver build phase");
  endfunction
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    $display("driver connect phase");
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    $display("driver run phase");
    forever begin
      seq_item_port.get_next_item(s_item);
      $display("driver item = %p", s_item);
      @(posedge my_vif.clk)
      my_vif.data_in <= s_item.data_in; 
      my_vif.addr <= s_item.addr;
      my_vif.en <= s_item.en;
      my_vif.re <= s_item.re;
      my_vif.rst <= s_item.rst;
      #1step $display("driver data = %p", my_vif.data_in);
      seq_item_port.item_done();
    end
  endtask
  function void extract_phase (uvm_phase phase);
    super.extract_phase(phase);
    $display("driver extract phase");
  endfunction
endclass
