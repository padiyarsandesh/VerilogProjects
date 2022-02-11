module wptr_full #(parameter ADD_SIZE = 4) (
    output reg wfull,
    output [ADD_SIZE-1:0]waddr,
    output reg [ADD_SIZE:0]wptr,
    input [ADD_SIZE:0] wq2_rptr,
    input winc,wclk,wrst_n
);

reg [ADD_SIZE:0] wbin;
wire [ADD_SIZE:0] wgray_next,wbin_next;
wire wfull_val;

always @(posedge wclk,negedge wrst_n)
begin
    if(!wrst_n)
    {wptr,wbin} <=0;
    else
    {wptr,wbin} <= {wgray_next,wbin_next};
end

assign waddr = wbin[ADD_SIZE-1:0];
assign wbin_next = wbin + (winc & (~wfull));
assign wgray_next = wbin_next ^ (wbin_next>>1);
assign wfull_val = (wgray_next=={~wq2_rptr[ADD_SIZE:ADD_SIZE-1],wq2_rptr[ADD_SIZE-2:0]});

always @(posedge wclk,negedge wrst_n)
begin
    if(!wrst_n)
    wfull <= 1'b0;
    else 
    wfull <= wfull_val;
end

endmodule