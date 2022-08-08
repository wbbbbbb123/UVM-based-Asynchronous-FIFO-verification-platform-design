`ifndef READ_FIFO_SEQUENCER__SV
`define READ_FIFO_SEQUENCER__SV

class read_fifo_sequencer extends uvm_sequencer #(read_fifo_transaction);
   
   function new(string name = "read_fifo_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(read_fifo_sequencer)
endclass

`endif