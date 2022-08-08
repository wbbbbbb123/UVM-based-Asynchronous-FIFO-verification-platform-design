`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 10:54:38
// Design Name: 
// Module Name: rptr_empty
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


module rptr_empty 
#(parameter ADDRSIZE = 4)
 (
    output reg                rempty  ,
    output     [ADDRSIZE-1:0] raddr   ,
    output reg [ADDRSIZE :0]  rptr    ,
    input      [ADDRSIZE :0]  rq2_wptr,
    input                     rinc    , 
    input                     rclk    , 
    input                     rrst_n
);

reg [ADDRSIZE:0]        rbin;
wire [ADDRSIZE:0]       rgraynext;
wire [ADDRSIZE:0]       rbinnext;

//-------------------
// GRAYSTYLE2 pointer
//-------------------// 通过一级寄存器输出
always @(posedge rclk or negedge rrst_n)begin
    if (!rrst_n) 
		{rbin, rptr} <= 0;
    else 
		{rbin, rptr} <= {rbinnext, rgraynext};
end
// Memory read-address pointer (okay to use binary to address memory)
assign raddr = rbin[ADDRSIZE-1:0];          // 计算出二进制计数值对应的地址
assign rbinnext = rbin + (rinc & ~rempty);  // 不空就让二进制计数器加一，否则不变
assign rgraynext = (rbinnext>>1) ^ rbinnext;// 计算出二进制计数值对应的格雷码计数值

//---------------------------------------------------------------
// FIFO empty when the next rptr == synchronized wptr or on reset
//---------------------------------------------------------------
assign rempty_val = (rgraynext == rq2_wptr);// 生成 empty 信号

always @(posedge rclk or negedge rrst_n)begin
    if (!rrst_n) 
		rempty <= 1'b1;
    else 
		rempty <= rempty_val;
end
endmodule

