`include "define.sv"
`ifndef WRITE_FIFO_DRIVER__SV
`define WRITE_FIFO_DRIVER__SV
class write_fifo_driver extends uvm_driver#(my_transaction);

   virtual wr_if wr_if;
   logic no_tr = 1'b0;

   `uvm_component_utils(write_fifo_driver)
   function new(string name = "write_fifo_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if(!uvm_config_db#(virtual wr_if)::get(this, "", "wr_if", wr_if))
         `uvm_fatal("write_fifo_driver", "virtual interface must be set for wr_if!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
     extern task drive_one_pkt(my_transaction tr);
   extern task drive_nothing();
endclass

task write_fifo_driver::main_phase(uvm_phase phase);
   wr_if.wdata <= `DSIZE'b0;
   wr_if.winc  <= 1'b0;
   while(!wr_if.wrst_n)
      @(posedge wr_if.wclk);
   
   fork
       while(1) begin
          seq_item_port.get_next_item(req);
          no_tr = 1'b0;
          drive_one_pkt(req);
          no_tr = 1'b1;
          seq_item_port.item_done();
       end
       while (1) begin
           drive_nothing();
       end
   join
endtask

task write_fifo_driver::drive_one_pkt(my_transaction tr);
      `uvm_info("write_fifo_driver", "begin to drive one pkt", UVM_LOW);
      @(posedge wr_if.wclk);
      while(1) begin
        if (wr_if.wfull) begin
            //wait if full.
            wr_if.winc <= 1'b0;
            @(posedge wr_if.wclk);
        end
        else begin
          wr_if.winc<= 1'b1;
          wr_if.wdata <= tr.data;
          break;
        end
      end
      `uvm_info("write_fifo_driver", "end drive one pkt", UVM_LOW);


endtask
task write_fifo_driver::drive_nothing();
   @(posedge wr_if.wclk);
   if (no_tr) wr_if.winc<= 1'b0; //If no transaction. Drive the winc to zero.

endtask

`endif