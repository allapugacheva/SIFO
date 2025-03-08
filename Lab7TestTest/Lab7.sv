module Lab7 (
	input clk,
	input rst,
	
	output _grant1,
	output _grant2,
	output _grant3,
	output _grant4,
	
	output _request1,
	output _request2,
	output _request3,
	output _request4,
	
	output _busbusy,
	
	output [2:0] _address,
	output [7:0] _data,
	
	output [7:0] _outdata1,
	output [7:0] _outdata2,
	output [7:0] _outdata3,
	output [7:0] _outdata4,
	output [7:0] _outdata5,
	
	output [7:0] _priority
);

	logic [7:0] data;
	logic [2:0] address;
	
	assign _data = data;
	assign _address = address;
	assign _busbusy = busbusy;
	
	logic grant1, grant2, grant3, grant4;
	logic request1, request2, request3, request4;
	logic busbusy1, busbusy2, busbusy3, busbusy4;
	logic busbusy;

	assign busbusy = busbusy1 | busbusy2 | busbusy3 | busbusy4;
	
	assign _grant1 = grant1;
	assign _grant2 = grant2;
	assign _grant3 = grant3;
	assign _grant4 = grant4;
	assign _request1 = request1;
	assign _request2 = request2;
	assign _request3 = request3;
	assign _request4 = request4;
	assign _busbusy = busbusy;
	
	logic [7:0] data1, data2, data3, data4;
	always_comb begin
		if (grant1 & busbusy)
			data = data1;
		else if (grant2 & busbusy)
			data = data2;
		else if (grant3 & busbusy)
			data = data3;
		else if (grant4 & busbusy)
			data = data4;
		else
			data = 8'bz;
	end
	
	logic [2:0] address1, address2, address3, address4;
	always_comb begin
		if (grant1 & busbusy)
			address = address1;
		else if (grant2 & busbusy)
			address = address2;
		else if (grant3 & busbusy)
			address = address3;
		else if (grant4 & busbusy)
			address = address4;
		else
			address = 3'bz;
	end
	
	Master1 #(
		.MODULUS (14),
		.NUMBER (1)
	) master1 (
		.clk (clk),
		.rst (rst),
		.grant(grant1),
		.request(request1),
		.busbusy(busbusy1),
		.address(address1),
		.data(data1)
	);
	
	Master1 #(
		.MODULUS (8),
		.NUMBER (2)
	) master2 (
		.clk (clk),
		.rst (rst),
		.grant(grant2),
		.request(request2),
		.busbusy(busbusy2),
		.address(address2),
		.data(data2)
	);
		
	Master1 #(
		.MODULUS(12),
		.NUMBER (3)
	) master3 (
		.clk (clk),
		.rst (rst),
		.grant(grant3),
		.request(request3),
		.busbusy(busbusy3),
		.address(address3),
		.data(data3)
	);
	
	Master1 #(
		.MODULUS(3),
		.NUMBER (4)
	) master4 (
		.clk (clk),
		.rst (rst),
		.grant(grant4),
		.request(request4),
		.busbusy(busbusy4),
		.address(address4),
		.data(data4)
	);
	
	Slave1 slave1 (
		.clk (clk),
		.rst (rst),
		.enable (address == 3'd0),
		.indata(data),
		.outdata(_outdata1)
	);
	
	Slave1 slave2 (
		.clk (clk),
		.rst (rst),
		.enable (address == 3'd1),
		.indata(data),
		.outdata(_outdata2)
	);
	
	Slave1 slave3 (
		.clk (clk),
		.rst (rst),
		.enable (address == 3'd2),
		.indata(data),
		.outdata(_outdata3)
	);
	
	Slave1 slave4 (
		.clk (clk),
		.rst (rst),
		.enable (address == 3'd3),
		.indata(data),
		.outdata(_outdata4)
	);
	
	Slave1 slave5 (
		.clk (clk),
		.rst (rst),
		.enable (address == 3'd4),
		.indata(data),
		.outdata(_outdata5)
	);
	
	Arbitor (
		.clk (clk),
		.rst (rst),
		.request1 (request1),
		.request2 (request2),
		.request3 (request3),
		.request4 (request4),
		.busbusy (busbusy),
		.grant1 (grant1),
		.grant2 (grant2),
		.grant3 (grant3),
		.grant4 (grant4),
		._priority (_priority)
	);

endmodule

		
		
		
		
		
		