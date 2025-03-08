module Lab8 #(
	parameter ADDR_WIDTH = 9,
	          DATA_WIDTH = 6,
				 LINES = 8,
				 WORDS = 8,
				 TAG = 6
) ( 
	input                     clk,
	input                     rst,
	input  [ADDR_WIDTH - 1:0] addr,
	input                     read,
	input                     write,
	input  [DATA_WIDTH - 1:0] write_data,
	
	output                    hit,
	output [DATA_WIDTH - 1:0] data,
	output                    data_strob,
	
	output [ADDR_WIDTH - 1:0] ram_addr,
	output                    ram_read,
	output [DATA_WIDTH - 1:0] ram_data_out,
	output                    ram_write,
	output [DATA_WIDTH - 1:0] ram_data_in,
	
	output logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem       [0:LINES - 1],
	output [DATA_WIDTH - 1:0]                   data_sel,
	output [$clog2(WORDS):0]                    data_cnt,
	output logic [$clog2(WORDS) - 1:0]                last_save [0:WORDS - 1],
	output [$clog2(WORDS) - 1:0]                index,
	output [$clog2(WORDS) - 1:0]                write_index
);
	
	cache cache_dut (
		.clk (clk),
		.rst (rst),
		.addr (addr),
		.read (read),
		.write (write),
		.write_data (write_data),
		
		.hit (hit),
		.data (data),
		.data_strob (data_strob),
		
		.ram_addr (ram_addr),
		.ram_read (ram_read),
		.ram_data_out(ram_data_out),
		.ram_write(ram_write),
		.ram_data_in(ram_data_in),
		
		._mem(mem),
		._data_sel(data_sel),
		._data_cnt(data_cnt),
		._last_save(last_save),
		._index(index),
		._write_index(write_index)
	);
	
	ram ram_dut (
		.clk (clk),
		.addr(ram_addr),
		.write(ram_write),
		.data_in(ram_data_in),
		.read(ram_read),
		.data_out(ram_data_out)
	);

endmodule