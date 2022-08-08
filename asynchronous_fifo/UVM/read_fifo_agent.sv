`ifndef READ_FIFO_AGENT__SV
`define READ_FIFO_AGENT__SV

class read_fifo_agent extends uvm_agent ;
   read_fifo_sequencer  sqr;
   read_fifo_monitor    mon;
   read_fifo_driver     drv;
   
   uvm_analysis_port #(my_transaction)  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(read_fifo_agent)
endclass 


function void read_fifo_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   sqr = read_fifo_sequencer::type_id::create("sqr", this);
   mon = read_fifo_monitor::type_id::create("mon", this);
   drv = read_fifo_driver::type_id::create("drv", this);
endfunction 

function void read_fifo_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   drv.seq_item_port.connect(sqr.seq_item_export);
   ap = mon.ap;
endfunction

`endif
