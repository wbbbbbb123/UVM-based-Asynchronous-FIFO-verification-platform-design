`ifndef READ_FIFO_MONITOR__SV
`define READ_FIFO_MONITOR__SV
class read_fifo_monitor extends uvm_monitor;

   virtual rd_if rd_if;

  uvm_analysis_port #(my_transaction)  ap;
   
   `uvm_component_utils(read_fifo_monitor)
   function new(string name = "read_fifo_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
     if(!uvm_config_db#(virtual rd_if)::get(this, "", "rd_if", rd_if))
         `uvm_fatal("read_fifo_monitor", "virtual interface must be set for rd_if!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);
     extern task collect_one_pkt(my_transaction tr);
endclass

task read_fifo_monitor::main_phase(uvm_phase phase);
   my_transaction tr;
   while(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
   end
endtask

task read_fifo_monitor::collect_one_pkt(my_transaction tr);
   
   while(1) begin
      @(posedge rd_if.rclk);
      if(rd_if.rinc) break;
   end
   //`uvm_info("read_fifo_monitor", $sformatf("rd_if.rinc:%0h  rd_if.rdata:%0h",rd_if.rinc,rd_if.rdata), UVM_LOW);
  `uvm_info("read_fifo_monitor", "begin to collect one pkt", UVM_MEDIUM);
   tr.data = rd_if.rdata;
   //@(posedge rd_if.rclk);
   //`uvm_info("read_fifo_monitor", $sformatf("rd_if.rinc:%0h  rd_if.rdata:%0h",rd_if.rinc,rd_if.rdata), UVM_LOW);
   `uvm_info("read_fifo_monitor", "end collect one pkt", UVM_MEDIUM);
endtask


`endif