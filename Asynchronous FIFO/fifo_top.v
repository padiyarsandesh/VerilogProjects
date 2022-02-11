module fifo_top #(parameter ADD_SIZE =4,parameter DATA_SIZE =8) (
    output [DATA_SIZE-1:0] rdata,
    output wfull,
    output rempty,
    input [DATA_SIZE-1:0] wdata,
    input winc,wclk,wrst_n,
    input rinc,rclk,rrst_n
);

wire [ADD_SIZE-1:0] waddr,raddr;
wire [ADD_SIZE:0] wptr,rptr,wq2_rptr,rq2_wptr;

sync_r2w sync_rptr(.wq2_rptr(wq2_rptr),.rptr(rptr),.wclk(wclk),.wrst_n(wrst_n));
sync_w2r sync_wptr(.rq2_wptr(rq2_wptr),.wptr(wptr),.rclk(rclk),.rrst_n(rrst_n));

fifo_mem #(DATA_SIZE,ADD_SIZE) dual_port_RAM(.rdata(rdata),.wdata(wdata),.raddr(raddr),.waddr(waddr),.wclken(winc),.wfull(wfull),.wclk(wclk));

rptr_empty #(ADD_SIZE) empty_check(.rempty(rempty),.raddr(raddr),.rptr(rptr),.rq2_wptr(rq2_wptr),.rinc(rinc),.rclk(rclk),.rrst_n(rrst_n));
wptr_full #(ADD_SIZE) full_check(.wfull(wfull),.waddr(waddr),.wptr(wptr),.wq2_rptr(wq2_rptr),.winc(winc),.wclk(wclk),.wrst_n(wrst_n));

    
endmodule