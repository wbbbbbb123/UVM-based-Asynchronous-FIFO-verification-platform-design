`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 10:55:13
// Design Name: 
// Module Name: gray_sync2d
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


module gray_sync2d 
#(parameter ADDRSIZE = 4)
 (
    output reg [ADDRSIZE:0] o_ptr    ,
    input      [ADDRSIZE:0] i_ptr    ,
    input                   des_clk  ,
    input                   des_rst_n
);

//reg [ADDRSIZE:0] o_ptr;
reg [ADDRSIZE:0] temp_ptr;

always @(posedge des_clk or negedge des_rst_n)begin
    if (!des_rst_n) 
        {o_ptr,temp_ptr} <= 0;
    else 
        {o_ptr,temp_ptr} <= {temp_ptr,i_ptr};
end

endmodule

