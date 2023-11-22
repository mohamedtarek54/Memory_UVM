class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)
  my_sequence_item s_item;
  virtual intf my_vif;
  uvm_analysis_port#(my_sequence_item) my_analysis_port;
  
  function new (string name = "my_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vif", my_vif))
      `uvm_fatal(get_full_name(), "Error")
    my_analysis_port = new("my_analysis_port", this);
    s_item = my_sequence_item::type_id::create("s_item");
    $display("monitor build phase");
  endfunction
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    $display("monitor connect phase");
  endfunction
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge my_vif.clk)
      if(my_vif.valid_out == 1'b0) begin
        s_item.data_in <= my_vif.data_in;
        s_item.en <= my_vif.en;
        s_item.addr <= my_vif.addr;
        #1step my_analysis_port.write(s_item);
      end
      else if(my_vif.valid_out == 1'b1) begin
      s_item.data_out <= my_vif.data_out;
        s_item.re <= my_vif.re;
        s_item.addr <= my_vif.addr;
     #1step $display("monitor data = %p", s_item.data_out);
      my_analysis_port.write(s_item);
      end
    end
    $display("monitor run phase");
  endtask
  function void extract_phase (uvm_phase phase);
    super.extract_phase(phase);
    $display("monitor extract phase");
  endfunction
endclass
