module spi_master (
    clk,rst,data_in,ss_b,start,ready,cpol,cpha,divisor,done,mosi,miso,data_out,sclk
);
input clk,rst,start,cpol,cpha,miso;
input [15:0]divisor;
input [7:0]data_in;
output mosi,ready;
output [7:0]data_out;
output reg ss_b;
output  done;

parameter IDLE = 2'b00, cpha_delay = 2'b01 , half_cycle1 =2'b10, half_cycle2 = 2'b11;
output wire sclk;
reg sclk_cs;
wire sclk_ns;
reg ready1,done1;
reg [2:0]nbit_cs,nbit_ns;
reg [15:0] count_cs,count_ns;
reg [7:0]so_reg_ns,so_reg_cs;
reg [7:0]si_reg_ns,si_reg_cs;
reg [1:0] cs,ns;
reg ss;
wire pclk;

always @(posedge clk,negedge rst)
begin
    if(!rst)
    begin
         cs <= IDLE;
         count_cs <=0;
         sclk_cs <=0;
         si_reg_cs <=0;
         so_reg_cs <=0;
         nbit_cs <=0;
    end    
    else
    begin
        cs <= ns;
        count_cs <= count_ns;
        sclk_cs <= sclk_ns;
        si_reg_cs <=si_reg_ns;
        so_reg_cs <= so_reg_ns;
        nbit_cs <= nbit_ns;
    end
        
end

always @(*)
begin
    //Default Assignments
    ns = cs;
    ready1 = 0;
    done1 = 0;
    count_ns = count_cs;
    nbit_ns=nbit_cs;
    ss_b=1;
    si_reg_ns=si_reg_cs;
    so_reg_ns=so_reg_cs;
    case(cs)
        IDLE: begin
            ready1=1;
            count_cs =0;
            done1 = 0;
            ss_b=1;
            if(start)
            begin
            ready1 = 0;
                done1=0;
                ss_b = 0;
                so_reg_ns =data_in;
               if(cpha)
               ns = cpha_delay;
               else
               ns = half_cycle1;     
            end 
        end
        cpha_delay:begin
            ss_b=0;
            ready1=0;
            if(count_cs == divisor)
            begin
                 ns = half_cycle1;
                 count_ns = 0;
            end
            else
            count_ns = count_cs +1;
        end
        half_cycle1: begin
        ready1=0;
            ss_b=0;
            if(count_cs == divisor) //sclk 0 to 1
            begin
                ns = half_cycle2;
                si_reg_ns = {si_reg_cs[6:0],miso};
                count_ns =0;
            end
            else
            count_ns = count_cs +1;
        end
        half_cycle2: begin
        ready1=0;
            ss_b=0;
            if(count_cs == divisor) //sclk 1 to 0
            begin
                
                if(nbit_cs == 7)
                begin
                    nbit_ns = 0;
                    ns = IDLE;
                    ready1=1;
                    done1 =1;
                end
                else
                begin
                    so_reg_ns = {so_reg_cs[6:0],1'b0};
                    nbit_ns = nbit_cs +1;
                    ns = half_cycle1;
                    count_ns =0;
                end
                end
                else
                count_ns = count_cs +1;
                
            end
           
         endcase
end

assign pclk = ((ns==half_cycle2) && ~cpha) || ((ns==half_cycle1) && cpha);
assign sclk_ns = (cpol)?~pclk:pclk;
assign ready = ready1;
assign data_out = si_reg_cs;
assign mosi = so_reg_cs[7];
assign sclk = sclk_cs;
assign done =done1;




    
endmodule