module ram # (
	parameter ADDR_WIDTH = 9,
				 DATA_WIDTH = 6
) (
	input                     clk,
	input  [ADDR_WIDTH - 1:0] addr,
	input                     write,
	input  [DATA_WIDTH - 1:0] data_in,
	input                     read,
	output [DATA_WIDTH - 1:0] data_out
);

	logic [DATA_WIDTH - 1:0] mem [0:(1 << ADDR_WIDTH) - 1];
	
	assign data_out = read ? mem[addr] : 'z;
	
	always_ff @(posedge clk) begin
		if (write)
			mem[addr] <= data_in;
	end
	
	initial begin
		$readmemh("ram1.hex", mem);
	end

endmodule