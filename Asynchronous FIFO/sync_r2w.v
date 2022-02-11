module sync_r2w #(parameter ADD_SIZE = 4) (

        output reg [ADD_SIZE:0] wq2_rptr,
        input [ADD_SIZE:0] rptr,
        input wclk,wrst_n
);
reg [ADD_SIZE:0] wq1_ptr;

always @(posedge wclk or negedge wrst_n)
begin
    if(!wrst_n)
    {wq2_rptr,wq1_ptr} <= 0;
    else
    {wq2_rptr,wq1_ptr} <= {wq1_ptr,rptr};
end
    
endmodule