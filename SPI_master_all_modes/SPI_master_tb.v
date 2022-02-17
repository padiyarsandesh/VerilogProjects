`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2022 22:39:18
// Design Name: 
// Module Name: SPI_master_tb
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


module SPI_master_tb;
reg clk,rst,start,cpol,cpha,miso;
reg [15:0]divisor;
reg [7:0]data_in;
wire mosi,ready;
wire [7:0]data_out;
wire ss_b;
wire done;
wire sclk;

spi_master uut(.clk(clk),.rst(rst),.start(start),.cpol(cpol),.cpha(cpha),
                .miso(miso),.divisor(divisor),
                .data_in(data_in),.mosi(mosi),
                .ready(ready),.data_out(data_out),
                .ss_b(ss_b),.done(done),.sclk(sclk));
                
initial
begin 
clk =0;
cpol=0;
cpha=0;
rst = 1;
miso=1;
start =0;
divisor = 4;
end

always #10 clk = ~clk;
always #38 miso =~ miso;
initial 
begin
#15 rst =0;
#15 rst=1;
#5
data_in = 8'hA5;
#10 start =1;
#1760 start =0;
#10000 $finish;
end
            
         
endmodule
