`ifndef READ_FIFO_SEQ_SV
`define READ_FIFO_SEQ_SV

class read_fifo_seq extends uvm_sequence #(read_fifo_transaction);
   
   function  new(string name= "read_fifo_seq");
      super.new(name);
   endfunction 

   extern virtual task body();
   extern virtual task pre_body();
   extern virtual task post_body();

   `uvm_object_utils(read_fifo_seq)
endclass

task read_fifo_seq::body();
   read_fifo_transaction rd_trans; 
    `uvm_do(rd_trans)
    //`uvm_info("read_fifo_seq", "Get one transaction", UVM_MEDIUM)

endtask

task read_fifo_seq::pre_body();
    if(starting_phase != null) begin 
        starting_phase.raise_objection(this);
    end
endtask

task read_fifo_seq::post_body();
    if(starting_phase != null) begin 
        starting_phase.drop_objection(this);
    end
endtask
`endif