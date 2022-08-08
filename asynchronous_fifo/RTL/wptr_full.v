`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 10:54:56
// Design Name: 
// Module Name: wptr_full
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


module wptr_full 
#(parameter ADDRSIZE = 4)
 (
    output reg                wfull   ,
    output     [ADDRSIZE-1:0] waddr   ,
    output reg [ADDRSIZE :0]  wptr    ,
    input      [ADDRSIZE :0]  wq2_rptr,
    input                     winc    , 
    input                     wclk    , 
    input                     wrst_n
);

reg  [ADDRSIZE:0]       wbin     ;  
wire [ADDRSIZE:0]       wgraynext;
wire [ADDRSIZE:0]       wbinnext ;

// GRAYSTYLE2 pointer// 打一拍
always @(posedge wclk or negedge wrst_n)begin
    if (!wrst_n) 
        {wbin, wptr} <= 0;
    else 
        {wbin, wptr} <= {wbinnext, wgraynext}; 
end
// Memory write-address pointer (okay to use binary to address memory)
assign waddr = wbin[ADDRSIZE-1:0];          // 计算出二进制计数值对应的地址
assign wbinnext = wbin + (winc & ~wfull);   // 不满就让二进制计数器加一，否则不变
assign wgraynext = (wbinnext>>1) ^ wbinnext;// 计算出二进制计数值对应的格雷码计数值
//------------------------------------------------------------------
// Simplified version of the three necessary full-tests:
// assign wfull_val=((wgnext[ADDRSIZE] !=wq2_rptr[ADDRSIZE] ) &&
// (wgnext[ADDRSIZE-1] !=wq2_rptr[ADDRSIZE-1]) &&
// (wgnext[ADDRSIZE-2:0]==wq2_rptr[ADDRSIZE-2:0]));
//------------------------------------------------------------------
assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1],wq2_rptr[ADDRSIZE-2:0]});// 生成 full 信号
always @(posedge wclk or negedge wrst_n)begin
    if (!wrst_n) 
        wfull <= 1'b0;
    else 
        wfull <= wfull_val;
end
endmodule

