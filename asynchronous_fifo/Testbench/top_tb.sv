`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/19 16:11:32
// Design Name: 
// Module Name: top_tb
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
`timescale 1ns/1ns

module top_tb;
parameter DSIZE = 32;//位宽为32bit
parameter ASIZE = 4;//深度为2^4=16

parameter WPER = 50;//写周期
parameter RPER = 32;//读周期

wire [DSIZE-1:0]  rdata;

wire              wfull;
wire              rempty;
reg [DSIZE-1:0]   wdata;
reg               winc;
reg               wclk;
reg               wrst_n;
reg               rinc;
reg               rclk;
reg               rrst_n;
reg [DSIZE-1:0]   data;

initial begin
   rclk = 0;
   forever begin
      #(RPER>>1) rclk = ~rclk;
   end
end

initial begin
   wclk = 0;
   forever begin
      #(WPER>>1) wclk = ~wclk;
   end
end

initial begin
write_full_read_empty();
#400;
direct_read_during_write();
#400;
$finish; 
end


task init;
begin
   wrst_n= 0;
   rrst_n= 0;
   wdata=0;
   winc=0;
   rinc=0;
   data = 32'h0;
   #500;
   wrst_n= 1;
   rrst_n= 1;
   #200;
end
endtask

integer i = 100;
task write;
    //fork
        while(1)begin
            @(posedge wclk);
            if(wfull==0)begin
                winc = 1'b1;
                wdata = i;
                i = i -1;
                @(posedge wclk);
                winc = 1'b0;
                break;
            end
            else begin
                winc = 1'b0;
                wdata = 32'h0;
                @(posedge wclk);
            end
        end
    //join
endtask

task read;
    //fork
        while(1)begin
            @(posedge rclk);
            if(rempty==0)begin
                rinc = 1'b1;   
                @(posedge rclk);
                data = rdata;  
                rinc = 1'b0;     
                break;
            end
            else begin
                rinc = 1'b0;
                //data = 32'h0;
                @(posedge rclk);
            end
        end  
    //join  
endtask

task direct_read_during_write;
        init();
      repeat(16)begin
        write();
        read();
      end
endtask


task write_full_read_empty;
    //begin
        init();
        repeat(16)begin
           write();
        end
        
        repeat(16)begin
           read();
        end
    //end
endtask

async_fifo #(.DSIZE(DSIZE),
              .ASIZE(ASIZE)
              )
async_fifo(
            .rdata(rdata),
            .wfull(wfull),
            .rempty(rempty),
            .wdata(wdata),
            .winc(winc), 
            .wclk(wclk), 
            .wrst_n(wrst_n),
            .rinc(rinc), 
            .rclk(rclk), 
            .rrst_n(rrst_n)
        );

endmodule
