`include "memory.v"
module tb;
	
	parameter DEPTH=32;
	parameter WIDTH=16;
	parameter ADDR_WIDTH=5;

	reg clk,res,wr_en;
	reg [ADDR_WIDTH-1:0]wr_addr;
	reg [WIDTH-1:0]wdata;
	reg [ADDR_WIDTH-1:0]rd_addr;
	wire [WIDTH-1:0]rdata;

	reg [8*30-1:0]test_name;

	integer i,j;

	memory #(.DEPTH(DEPTH),.WIDTH(WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut(.clk(clk),.res(res),.wr_addr(wr_addr),.rd_addr(rd_addr),.wr_en(wr_en),.wdata(wdata),.rdata(rdata));


	//reset task
	task res_mem();
		begin
	 		res=1;
			wr_en=0;
			wdata=0;
			wr_addr=0;
			rd_addr=0;
			repeat(2)@(posedge clk);
			res=0;
		end
	endtask

	//write task
	task mem_write(input integer start_point, input integer end_point);
		begin
			for(i=start_point;i<end_point;i=i+1) begin
				@(posedge clk);
				wr_en=1;
				wr_addr=i;
				wdata=$urandom_range(10,30);
				$display("WRITE::ADDR=%0d DATA=%0d TIME=%0t",wr_addr,wdata,$time);
			end
			@(posedge clk);
			wr_en=0;
			wr_addr=0;
			wdata=0;
			$display("------------------------------------");
		end
	endtask

	//read task
	task read_mem(input integer start_point, input integer end_point);
		begin
			repeat(2) @(posedge clk);
			for(j=start_point;j<end_point;j=j+1) begin
				@(posedge clk);
				rd_addr=j;
				@(posedge clk);
				#1;
				$display("READ::ADDR=%0d DATA=%0t TIME=%0t",rd_addr,rdata,$time);
			end
			@(posedge clk);
			rd_addr=0;
		end
	endtask

	//clock generation
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end

	initial begin
		res_mem();
		fork 
			mem_write(0,DEPTH);
			read_mem(0,DEPTH);
		join
		#20;
		$finish;
	end
endmodule
