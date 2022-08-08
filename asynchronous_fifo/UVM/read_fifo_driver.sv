`ifndef READ_FIFO_DRIVER__SV
`define READ_FIFO_DRIVER__SV
class read_fifo_driver extends uvm_driver#(read_fifo_transaction);

   virtual rd_if rd_if;
   logic no_tr = 1'b0;

   `uvm_component_utils(read_fifo_driver)
   function new(string name = "read_fifo_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual rd_if)::get(this, "", "rd_if", rd_if))
         `uvm_fatal("read_fifo_driver", "virtual interface must be set for rd_if!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(read_fifo_transaction tr);
   extern task drive_nothing();
endclass

task read_fifo_driver::main_phase(uvm_phase phase);
   rd_if.rinc  <= 1'b0;
   while(!rd_if.rrst_n)
      @(posedge rd_if.rclk);
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

task read_fifo_driver::drive_one_pkt(read_fifo_transaction tr);
      @(posedge rd_if.rclk);
      while(1) begin
        if (rd_if.rempty) begin
            //wait if empty.
            rd_if.rinc <= 1'b0;
            @(posedge rd_if.rclk);
        end
        else begin
          rd_if.rinc<= 1'b1;
          break;
        end
      end

endtask

task read_fifo_driver::drive_nothing();
   @(posedge rd_if.rclk);
   if (no_tr) rd_if.rinc<= 1'b0; //If no transaction. Drive the rinc to zero.

endtask

`endif