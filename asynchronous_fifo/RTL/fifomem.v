`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 10:54:14
// Design Name: 
// Module Name: fifomem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifomem 
#(parameter DATASIZE = 8, // Memory data word width
  parameter ADDRSIZE = 4) // Number of mem address bits
 (
  output [DATASIZE-1:0] rdata,
  input  [DATASIZE-1:0] wdata,
  input  [ADDRSIZE-1:0] waddr, 
  input  [ADDRSIZE-1:0] raddr,
  input                 wclken, 
  input                 wfull, 
  input                 wclk
 );
 
localparam DEPTH = 1<<ADDRSIZE;
reg [DATASIZE-1:0] mem [0:DEPTH-1];
assign rdata = mem[raddr];
always @(posedge wclk)begin
    if (wclken && !wfull) 
        mem[waddr] <= wdata;
end

//`ifdef VENDORRAM
//// instantiation of a vendor's dual-port RAM
//// Not defined for now.
//vendor_ram mem (.dout(rdata), 
//                .din(wdata),
//                .waddr(waddr), 
//                .raddr(raddr),
//                .wclken(wclken),
//                .wclken_n(wfull), 
//                .clk(wclk));
//`else
//// RTL Verilog memory model
//localparam DEPTH = 1<<ADDRSIZE;
//reg [DATASIZE-1:0] mem [0:DEPTH-1];
//assign rdata = mem[raddr];
//always @(posedge wclk)
//    if (wclken && !wfull) mem[waddr] <= wdata;
//`endif

endmodule

