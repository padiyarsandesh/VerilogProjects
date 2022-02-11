module sync_w2r #(parameter ADD_SIZE = 4) (

        output reg [ADD_SIZE:0] rq2_wptr,
        input [ADD_SIZE:0] wptr,
        input rclk,rrst_n
);
reg [ADD_SIZE:0] rq1_ptr;

always @(posedge rclk or negedge rrst_n)
begin
    if(!rrst_n)
    {rq2_wptr,rq1_ptr} <= 0;
    else
    {rq2_wptr,rq1_ptr} <= {rq1_ptr,wptr};
end
    
endmodule