module memory(clk,res,wr_addr,rd_addr,wr_en,wdata,rdata);
	
	parameter DEPTH=16;
	parameter WIDTH=8;
	parameter ADDR_WIDTH=4;

	input clk,res,wr_en;
	input [ADDR_WIDTH-1:0]wr_addr;
	input [WIDTH-1:0]wdata;
	input [ADDR_WIDTH-1:0]rd_addr;
	output reg [WIDTH-1:0]rdata;

	reg [WIDTH-1:0] mem [DEPTH-1:0];

	integer i;

	always@(posedge clk) begin
		if(res) begin
			rdata<=0;
			for(i=0;i<DEPTH;i=i+1) mem[i]<=0;
		end
		else begin
			if(wr_en) mem[wr_addr]<=wdata;
			
			rdata<=mem[rd_addr];
		end
	end
endmodule
