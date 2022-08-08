`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 10:53:50
// Design Name: 
// Module Name: async_fifo
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


module async_fifo 
#(parameter DSIZE = 8,
  parameter ASIZE = 4)
 (  //output
    output [DSIZE-1:0]rdata ,//读出数据
    output            wfull ,//写满信号
    output            rempty,//读空信号
    //input wr                  
    input [DSIZE-1:0] wdata ,//写入数据
    input             winc  ,//写入使能
    input             wclk  ,//写时钟 
    input             wrst_n,//写复位
    //input rd                  
    input             rinc  ,//读出使能 
    input             rclk  ,//读时钟  
    input             rrst_n //读复位
);


wire [ASIZE-1:0]    waddr   ;//写地址
wire [ASIZE-1:0]    raddr   ;//读地址
wire [ASIZE:0]      wptr    ;//写指针(格雷码)
wire [ASIZE:0]      rptr    ;//读指针(格雷码)
wire [ASIZE:0]      wq2_rptr;//写指针打两拍
wire [ASIZE:0]      rq2_wptr;//读指针打两拍
//打两拍(消除亚稳态影响)
gray_sync2d sync_r2w (
    .o_ptr(wq2_rptr), 
    .i_ptr(rptr),
    .des_clk(wclk), 
    .des_rst_n(wrst_n)
);
//打两拍
gray_sync2d sync_w2r (
    .o_ptr(rq2_wptr), 
    .i_ptr(wptr),
    .des_clk(rclk), 
    .des_rst_n(rrst_n)
);
//FIFO sram
fifomem #(DSIZE, ASIZE) fifomem (
    .rdata(rdata), 
    .wdata(wdata),
    .waddr(waddr), 
    .raddr(raddr),
    .wclken(winc), 
    .wfull(wfull),
    .wclk(wclk)
);
//读fifo控制
rptr_empty #(ASIZE) rptr_empty(
    .rempty(rempty),
    .raddr(raddr),
    .rptr(rptr), 
    .rq2_wptr(rq2_wptr),
    .rinc(rinc), 
    .rclk(rclk),
    .rrst_n(rrst_n)
);
//写fifo控制
wptr_full #(ASIZE) wptr_full (
    .wfull(wfull), 
    .waddr(waddr),
    .wptr(wptr), 
    .wq2_rptr(wq2_rptr),
    .winc(winc), 
    .wclk(wclk),
    .wrst_n(wrst_n)
);

endmodule

