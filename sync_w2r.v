`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2023 21:12:53
// Design Name: 
// Module Name: sync_w2r
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


module sync_w2r(rq2_wptr,wptr,rclk, rrst_n);//Write-domain to read-domain synchronizer
parameter ADDRSIZE = 4;                     ////i.e converting write pointer to rclk domain
output reg [ADDRSIZE:0] rq2_wptr;
input [ADDRSIZE:0] wptr;
input rclk, rrst_n;
reg [ADDRSIZE:0] rq1_wptr;
always @(posedge rclk or negedge rrst_n)
 if (!rrst_n) {rq2_wptr,rq1_wptr} <= 0;
 else {rq2_wptr,rq1_wptr} <= {rq1_wptr,wptr};
endmodule
