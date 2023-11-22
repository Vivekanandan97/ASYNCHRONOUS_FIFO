`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2023 21:10:00
// Design Name: 
// Module Name: fifo
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


module fifo( rdata,wfull,rempty,wdata,winc, wclk, wrst_n,rinc, rclk, rrst_n);  //FIFO top-level module
 parameter DSIZE = 8;
 parameter ASIZE = 4;

output [DSIZE-1:0] rdata;
 output wfull;
 output rempty;
 input [DSIZE-1:0] wdata;
 input winc, wclk, wrst_n;
 input rinc, rclk, rrst_n;

 wire [ASIZE-1:0] waddr, raddr;
 wire [ASIZE:0] wptr, rptr, wq2_rptr, rq2_wptr;
 
 //Instantiation of sync_r2w
 sync_r2w sync_r2w (.wq2_rptr(wq2_rptr), .rptr(rptr),.wclk(wclk), .wrst_n(wrst_n));
 
 //Instantiation of sync_w2r
 sync_w2r sync_w2r (.rq2_wptr(rq2_wptr), .wptr(wptr),.rclk(rclk), .rrst_n(rrst_n));
 
 //Instantiation of fifomem
 fifomem  fifomem (.rdata(rdata), .wdata(wdata),.waddr(waddr), .raddr(raddr), .wclken(winc), .wfull(wfull),.wclk(wclk));
 
 //Instantiation of rptr_empty 
 rptr_empty  rptr_empty (.rempty(rempty),.raddr(raddr),.rptr(rptr), .rq2_wptr(rq2_wptr),.rinc(rinc), .rclk(rclk),.rrst_n(rrst_n));
 
 //Instantiation of wptr_full
 wptr_full  wptr_full (.wfull(wfull), .waddr(waddr),.wptr(wptr), .wq2_rptr(wq2_rptr),.winc(winc), .wclk(wclk),.wrst_n(wrst_n));
     
endmodule
