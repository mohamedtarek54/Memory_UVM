class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)
  uvm_tlm_analysis_fifo#(my_sequence_item) my_tlm_analysis_fifo;
  uvm_analysis_export#(my_sequence_item) my_analysis_export;
  my_sequence_item s_item;
  logic [31:0] write_item [16];
  function new (string name = "my_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    my_tlm_analysis_fifo = new("my_tlm_analysis_fifo", this);
    my_analysis_export = new("my_analysis_export", this);
    
      $display("scoreboard build phase");
  endfunction
  function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    my_analysis_export.connect(my_tlm_analysis_fifo.analysis_export);
    $display("scoreboard connect phase");
  endfunction
  task run_phase(uvm_phase phase);
    $display("scoreboard run phase");
    super.run_phase(phase);
    forever begin
      static int q[$];
    my_tlm_analysis_fifo.get_peek_export.get(s_item);
      $display("scoreboard item out = %p", s_item.data_out);
      $display("scoreboard item addr = %p", s_item.addr);
      if(s_item.en == 1'b1)
        write_item[s_item.addr] = s_item.data_in;
      else if(s_item.re == 1'b1) begin
        if(s_item.data_out == q.pop_back())
          $display("scoreboard Successs");
        else begin
          $display("actual: %h, stored: %h, address: %p", s_item.data_out, write_item[s_item.addr], s_item.addr);
          $display("queue: %h", q.pop_back());
          $display("scoreboard Faliure");
        end
        q.insert(0,write_item[s_item.addr]);
      end
    end
    
  endtask
  function void extract_phase (uvm_phase phase);
    super.extract_phase(phase);
    $display("scoreboard extract phase");
  endfunction
endclass
