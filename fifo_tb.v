`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2023 00:44:15
// Design Name: 
// Module Name: fifo_tb
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


module fifo_tb();
    parameter w_cycle = 12.5;
    parameter r_cycle = 20;
    parameter DSIZE = 8;
    parameter ASIZE = 4;
    wire rempty,wfull;
    wire [0:DSIZE-1]rdata;
    reg [DSIZE-1:0]wdata;
    reg wrst_n,wclk,rclk,rrst_n;
    reg winc,rinc;
    integer i,j;
  
    
   fifo i1( .rdata(rdata),.wfull(wfull),.rempty(rempty),.wdata(wdata),.winc(winc), .wclk(wclk), .wrst_n(wrst_n),.rinc(rinc), .rclk(rclk),.rrst_n(rrst_n) );
   always
    begin
    #(w_cycle/2) wclk = 1;
    #(w_cycle/2) wclk = 0;
    end
    
    always
    begin
    #(r_cycle/2) rclk = 1;
    #(r_cycle/2) rclk = 0;
    end
    
    task wdata_winc_t;
      begin
             for(i=0;i<8;i=i+1)
                begin
                   @(posedge wclk)
                    wdata = {$random};
                    winc = 1;                
                end
             winc = 0;   
      end
    endtask
    
   task rdata_rinc_t;
      begin
          for(j=0;j<8;j=j+1)
            begin
              @(posedge rclk)
              rinc = 1 ;
            end 
              rinc = 0 ;  
      end
    endtask
   
initial 
begin
wclk = 0;
rclk = 0;
winc = 0;
rinc = 0;
wrst_n = 0;
rrst_n = 0;
wdata = 0;

@(negedge wclk)
wrst_n = 1;
rrst_n = 1;

end

initial
begin
@(posedge wclk)
wdata_winc_t;
end

initial
@(posedge rclk)
begin
rdata_rinc_t;
end

endmodule
