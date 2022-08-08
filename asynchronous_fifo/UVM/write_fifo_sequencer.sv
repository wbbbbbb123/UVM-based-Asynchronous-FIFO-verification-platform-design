`ifndef WRITE_FIFO_SEQUENCER__SV
`define WRITE_FIFO_SEQUENCER__SV

class write_fifo_sequencer extends uvm_sequencer #(my_transaction);
   
   function new(string name = "write_fifo_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(write_fifo_sequencer)
endclass

`endif