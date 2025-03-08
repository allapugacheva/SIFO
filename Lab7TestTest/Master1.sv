module Master1 #(
    parameter MODULUS = 6,
    parameter NUMBER = 1
) (
	input        clk,
	input 		 rst,
	input        grant,
	output       request,
	output       busbusy,
	output [2:0] address,
	output [7:0] data
);

	logic [4:0] counter_requests;
	logic [2:0] counter_quant;
	logic [2:0] counter_address;
	
	assign data = NUMBER;
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			counter_address <= 'd0;
		else if (~request)
			counter_address <= counter_address == 5'd4 ? 'd0 : counter_address + 1'b1;
	end
	
	assign address = counter_address;
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			request <= 1'b0;
		else if (counter_requests == MODULUS)
			request <= 1'b1;
		else if (counter_quant == 3'd4)
			request <= 1'b0;
	end
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			counter_requests <= 'd0;
		else if (~request)
			counter_requests <= counter_requests == MODULUS ? 4'd0 : counter_requests + 1'b1;
	end
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			counter_quant <= 'd0;
		else if (grant)
			counter_quant <= counter_quant + 1'b1;
		else if (counter_quant != 3'd0 & ~request)
			counter_quant <= 'd0;
	end
	
	assign busbusy = grant & request;
	
endmodule
