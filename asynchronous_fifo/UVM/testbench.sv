`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "define.sv"
`include "my_if.sv"
`include "my_transaction.sv"
`include "read_fifo_transaction.sv"
`include "write_fifo_sequencer.sv"
`include "read_fifo_sequencer.sv"
`include "write_fifo_seq.sv"
`include "read_fifo_seq.sv"
`include "my_virtual_sequencer.sv"
`include "write_fifo_driver.sv"
`include "read_fifo_driver.sv"
`include "write_fifo_monitor.sv"
`include "read_fifo_monitor.sv"
`include "write_fifo_agent.sv"
`include "read_fifo_agent.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"
`include "my_env.sv"
`include "base_test.sv"
`include "my_case0.sv"
`include "my_case1.sv"
`include "my_case2.sv"
module top_tb;

  
reg wclk;
reg rclk;
reg wrst_n;
reg rrst_n;
reg rinc;

wr_if wr_if(wclk, wrst_n);
rd_if rd_if(rclk, rrst_n);

  async_fifo  #(
    .DSIZE(`DSIZE),
    .ASIZE(`ASIZE)
  )
  async_fifo(

    .rdata(rd_if.rdata),
    .wfull(wr_if.wfull),
    .rempty(rd_if.rempty),
    .wdata(wr_if.wdata),
    .winc(wr_if.winc), 
    .wclk(wclk), 
    .wrst_n(wrst_n),
    .rinc(rd_if.rinc), 
    .rclk(rclk), 
    .rrst_n(rrst_n)
  );


initial begin
   wclk = 0;
   forever begin
     #(`WPERIOD>>1) wclk = ~wclk;
   end
end

initial begin
   rclk = 0;
   forever begin
     #(`RPERIOD>>1) rclk = ~rclk;
   end
end

initial begin
   wrst_n = 1'b0;
   rrst_n = 1'b0;
   $display("DATA_DEPTH:%0d",`DATA_DEPTH);
   #1000;
   wrst_n = 1'b1;
   rrst_n = 1'b1;
end

initial begin
  run_test("my_case0");
  
end

initial begin
   uvm_config_db#(virtual wr_if)::set(null, "uvm_test_top.env.i_agt.drv", "wr_if", wr_if);
   uvm_config_db#(virtual wr_if)::set(null, "uvm_test_top.env.i_agt.mon", "wr_if", wr_if);
   uvm_config_db#(virtual rd_if)::set(null, "uvm_test_top.env.o_agt.drv", "rd_if", rd_if);
   uvm_config_db#(virtual rd_if)::set(null, "uvm_test_top.env.o_agt.mon", "rd_if", rd_if);
end

// vcd
initial begin
  $dumpfile("top_tb.vcd");
  $dumpvars;
end

endmodule