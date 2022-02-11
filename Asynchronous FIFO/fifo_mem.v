module fifo_mem #(parameter DATA_SIZE = 8 ,
                    parameter ADD_SIZE=4) (
                        output [DATA_SIZE-1:0] rdata,
                        input [DATA_SIZE-1:0] wdata,
                        input [ADD_SIZE-1:0] raddr,waddr,
                        input wclken,wfull,wclk
    
);

localparam DEPTH = 1<<ADD_SIZE ;
reg [DATA_SIZE-1:0] mem [0:DEPTH-1];

assign rdata = mem[raddr];

always @(posedge wclk)
begin 
    if(wclken && !wfull)
    mem[waddr] = wdata;
end
    
endmodule