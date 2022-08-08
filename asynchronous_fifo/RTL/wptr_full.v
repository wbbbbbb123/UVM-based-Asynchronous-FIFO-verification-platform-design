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

// GRAYSTYLE2 pointer// ��һ��
always @(posedge wclk or negedge wrst_n)begin
    if (!wrst_n) 
        {wbin, wptr} <= 0;
    else 
        {wbin, wptr} <= {wbinnext, wgraynext}; 
end
// Memory write-address pointer (okay to use binary to address memory)
assign waddr = wbin[ADDRSIZE-1:0];          // ����������Ƽ���ֵ��Ӧ�ĵ�ַ
assign wbinnext = wbin + (winc & ~wfull);   // �������ö����Ƽ�������һ�����򲻱�
assign wgraynext = (wbinnext>>1) ^ wbinnext;// ����������Ƽ���ֵ��Ӧ�ĸ��������ֵ
//------------------------------------------------------------------
// Simplified version of the three necessary full-tests:
// assign wfull_val=((wgnext[ADDRSIZE] !=wq2_rptr[ADDRSIZE] ) &&
// (wgnext[ADDRSIZE-1] !=wq2_rptr[ADDRSIZE-1]) &&
// (wgnext[ADDRSIZE-2:0]==wq2_rptr[ADDRSIZE-2:0]));
//------------------------------------------------------------------
assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1],wq2_rptr[ADDRSIZE-2:0]});// ���� full �ź�
always @(posedge wclk or negedge wrst_n)begin
    if (!wrst_n) 
        wfull <= 1'b0;
    else 
        wfull <= wfull_val;
end
endmodule

