`ifndef WRITE_FIFO_AGENT__SV
`define WRITE_FIFO_AGENT__SV

class write_fifo_agent extends uvm_agent ;
   write_fifo_sequencer  sqr;
   write_fifo_driver     drv;
   write_fifo_monitor    mon;
   
  uvm_analysis_port #(my_transaction)  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(write_fifo_agent)
endclass 


function void write_fifo_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   sqr = write_fifo_sequencer::type_id::create("sqr", this);
   drv = write_fifo_driver::type_id::create("drv", this);
   mon = write_fifo_monitor::type_id::create("mon", this);
endfunction 

function void write_fifo_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   drv.seq_item_port.connect(sqr.seq_item_export);
   ap = mon.ap;
endfunction

`endif
