module fifo_tb;
parameter DATA_SIZE=8;
parameter ADD_SIZE=4;

wire [DATA_SIZE-1:0]rdata;
wire wfull;
wire rempty;
reg [DATA_SIZE-1:0] wdata;
reg winc,wclk,wrst_n;
reg rinc,rclk,rrst_n;

initial 
begin
    rclk=0;
    winc=1;
    rinc=1;
forever 
begin
    #10 rclk = ~rclk;
end

initial 
begin
    wclk=0;
forever 
begin
    #6 wclk = ~wclk;
end

initial begin
    wrst_n = 0;
    rrst_n =0;
#3 wrst_n=1; rrst_n=0;
    #10 wdata = 8'h30;
    #10 wdata = 8'h20;
    #10 wdata = 8'h10;
    #10 wdata = 8'h15;
    #10 wdata = 8'h34;
    #10 wdata = 8'hA0;
    #10 wdata = 8'h69;

end

endmodule