module rptr_empty(rempty,raddr,rptr,rq2_wptr,rinc, rclk, rrst_n);   //Read pointer & empty generation logic
parameter ADDRSIZE = 4;

output reg rempty;
output [ADDRSIZE-1:0] raddr;
output reg [ADDRSIZE :0] rptr;
input [ADDRSIZE :0] rq2_wptr;
input rinc, rclk, rrst_n;

reg [ADDRSIZE:0] rbin;
wire [ADDRSIZE:0] rgraynext, rbinnext;

always @(posedge rclk or negedge rrst_n) //Dual n-bit Gray code counter
 if (!rrst_n) {rbin, rptr} <= 0;
 else {rbin, rptr} <= {rbinnext, rgraynext};
 
 assign raddr = rbin[ADDRSIZE-1:0]; //using binary to address memory
 assign rbinnext = rbin + (rinc & ~rempty);
 assign rgraynext = (rbinnext>>1) ^ rbinnext;
 
 assign rempty_val = (rgraynext == rq2_wptr);   // FIFO empty when the next rptr == synchronized wptr or on reset
 always @(posedge rclk or negedge rrst_n)
 if (!rrst_n) rempty <= 1'b1;
 else rempty <= rempty_val;

endmodule