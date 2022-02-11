module rptr_empty #(parameter ADD_SIZE = 4 ) (
    output reg  rempty,
    output  [ADD_SIZE-1:0] raddr,
    output reg [ADD_SIZE:0] rptr,
    input [ADD_SIZE:0] rq2_wptr,
    input rclk,rrst_n,rinc
);

reg [ADD_SIZE:0] rbin;
wire [ADD_SIZE:0] rgray_next,rbin_next;
wire rempty_val;
always @(posedge rclk, negedge rrst_n)
begin
    if(!rrst_n)
    {rbin,rptr} <= 0;
    else
    {rbin,rptr} <= {rbin_next,rgray_next};
end

assign raddr = rbin[ADD_SIZE-1:0];

assign rbin_next = rbin + (rinc & (~rempty));
assign rgray_next = rbin_next ^ (rbin_next>>1);

assign rempty_val = (rgray_next == rq2_wptr);

always @(posedge rclk,negedge rrst_n)
begin
    if(!rrst_n)
    rempty <= 1'b1;
    else
    rempty <= rempty_val;
end

endmodule

