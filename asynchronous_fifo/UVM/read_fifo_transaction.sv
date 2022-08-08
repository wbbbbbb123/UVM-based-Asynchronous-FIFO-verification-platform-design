`ifndef READ_FIFO_TRANSACTION__SV
`define READ_FIFO_TRANSACTION__SV

class read_fifo_transaction extends uvm_sequence_item;

   rand bit rinc;

   `uvm_object_utils_begin(read_fifo_transaction)
      `uvm_field_int(rinc, UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name = "read_fifo_transaction");
      super.new();
   endfunction
  
endclass
`endif