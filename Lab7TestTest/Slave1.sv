module Slave1 (
	input        clk,
	input        rst,
	input        enable,
	input  [7:0] indata,
	output [7:0] outdata
);
	
	logic [7:0] data;
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			data <= 'd0;
		else if (enable)
			data <= indata;
	end
	
	assign outdata = data;
	
endmodule
	