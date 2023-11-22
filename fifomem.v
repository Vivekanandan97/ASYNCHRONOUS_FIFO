module fifomem(rdata,wdata,waddr,raddr,wclken, wfull, wclk); //FIFO memory buffer

parameter DATASIZE = 8;// DATASIZE (MEMORY WIDTH )
parameter ADDRSIZE = 4;// ADDRESS SIZE(MEMORY DEPTH ) 

output [DATASIZE-1:0] rdata;
input [DATASIZE-1:0] wdata;
input [ADDRSIZE-1:0] waddr, raddr;

input wclken, wfull, wclk;


reg [DATASIZE-1:0] mem [0:ADDRSIZE-1]; // [0:ADDRSIZE-1] for adddress starts from 0
assign rdata = mem[raddr];
always @(posedge wclk)
if (wclken && !wfull)  // winc is ported with wclken
 mem[waddr] <= wdata;

endmodule


