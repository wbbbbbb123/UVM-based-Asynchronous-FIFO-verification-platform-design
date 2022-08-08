`ifndef WRITE_FIFO_SEQ_SV
`define WRITE_FIFO_SEQ_SV

class write_fifo_seq extends uvm_sequence #(my_transaction);
   
   function  new(string name= "write_fifo_seq");
      super.new(name);
   endfunction 

   extern virtual task body();
   extern virtual task pre_body();
   extern virtual task post_body();

   `uvm_object_utils(write_fifo_seq)
endclass

task write_fifo_seq::body();
    my_transaction my_trans; 
    `uvm_do(my_trans)
    //`uvm_info("write_fifo_seq", "send one transaction", UVM_MEDIUM)

endtask

task write_fifo_seq::pre_body();
//    if(starting_phase != null) begin 
//        starting_phase.raise_objection(this);
//    end
endtask

task write_fifo_seq::post_body();
//    if(starting_phase != null) begin 
//        starting_phase.drop_objection(this);
//    end
endtask
`endif
