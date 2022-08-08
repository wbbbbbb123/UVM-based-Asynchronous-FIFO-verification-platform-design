`include "define.sv"
`ifndef MY_IF__SV
`define MY_IF__SV

interface wr_if(input wclk, input wrst_n);

   logic [`DSIZE-1:0] wdata;
   logic winc;
   logic wfull;
endinterface

interface rd_if(input rclk, input rrst_n);

   logic [`DSIZE-1:0] rdata;
   logic rinc;
   logic rempty;
endinterface
`endif 