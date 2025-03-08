`timescale 1 ns / 1 ps

module tb ();

	localparam ADDR_WIDTH = 9;
	localparam DATA_WIDTH = 6;
	localparam LINES = 8;
	localparam WORDS = 8;
	localparam TAG = 6;

	logic                    clk;
	logic                    rst;
	logic [ADDR_WIDTH - 1:0] addr;
	logic                    read;
	logic                    write;
	logic [DATA_WIDTH - 1:0] write_data;
	
	logic                    hit;
	logic [DATA_WIDTH - 1:0] data;
	logic                    data_strob;
	
	logic [ADDR_WIDTH - 1:0] ram_addr;
	logic                    ram_read;
	logic [DATA_WIDTH - 1:0] ram_data_out;
	logic                    ram_write;
	logic [DATA_WIDTH - 1:0] ram_data_in;
	
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem1;
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem2;
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem3;
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem4;
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem5;
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem6;
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem7;
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem8;
	
	logic [$clog2(WORDS) - 1:0] last_save1;
	logic [$clog2(WORDS) - 1:0] last_save2;
	logic [$clog2(WORDS) - 1:0] last_save3;
	logic [$clog2(WORDS) - 1:0] last_save4;
	logic [$clog2(WORDS) - 1:0] last_save5;
	logic [$clog2(WORDS) - 1:0] last_save6;
	logic [$clog2(WORDS) - 1:0] last_save7;
	logic [$clog2(WORDS) - 1:0] last_save8;
	
	logic [1 + TAG + WORDS * DATA_WIDTH - 1:0] mem       [0:LINES - 1];
	logic [DATA_WIDTH - 1:0]                   data_sel;
	logic [$clog2(WORDS):0]                    data_cnt;
	logic [$clog2(WORDS) - 1:0]                last_save [0:WORDS - 1];
	logic [$clog2(WORDS) - 1:0]                index;
	logic [$clog2(WORDS) - 1:0]                write_index;
	
	assign mem1 = mem[0];
	assign mem2 = mem[1];
	assign mem3 = mem[2];
	assign mem4 = mem[3];
	assign mem5 = mem[4];
	assign mem6 = mem[5];
	assign mem7 = mem[6];
	assign mem8 = mem[7];
	
	assign last_save1 = last_save[0];
	assign last_save2 = last_save[1];
	assign last_save3 = last_save[2];
	assign last_save4 = last_save[3];
	assign last_save5 = last_save[4];
	assign last_save6 = last_save[5];
	assign last_save7 = last_save[6];
	assign last_save8 = last_save[7];
	
	Lab8 lab8_dut(
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
		.ram_data_out (ram_data_out),
		.ram_write (ram_write),
		.ram_data_in (ram_data_in),
		
		.mem (mem),
		.data_sel (data_sel),
		.data_cnt (data_cnt),
		.last_save (last_save),
		.index (index),
		.write_index (write_index)
	);

	initial begin
		clk = 1'b0;
	
		forever
			#5 clk = ~clk;
	end
	
	initial begin
		rst = 1'b1;
		
		#10 rst = 1'b0;
	end
	
	initial begin
		addr = '0;
		read = '0;
		write = '0;
		write_data = '0;
	end
	
	initial begin
		
		@(negedge rst);
		
		@(posedge clk);
		
		read = 1'b1;
		addr = 'd10;
		
		@(posedge data_strob);
		
		@(posedge clk);
		
		addr = 'd11;
		
		@(posedge data_strob);
		
		@(posedge clk);
		
		addr = 'd2;
		read = 1'b0;
		write = 1'b1;
		write_data = 5;
		
		repeat (11) @(posedge clk);
		
		addr = 'd3;
		write_data = 1;
		
		repeat (2) @(posedge clk);
		
		addr = 'd22;
		write_data = 55;
		
		repeat (11) @(posedge clk);
		
		addr = 'd34;
		read = 1'b1;
		write = 1'b0;
		
		@(posedge data_strob);
		
		@(posedge clk);
		
		addr = 'd67;
		
		@(posedge data_strob);
		
		@(posedge clk);

		addr = 'd90;
		
		@(posedge data_strob);
		
		@(posedge clk);	
	
		addr = 'd111;
		
		@(posedge data_strob);
		
		@(posedge clk);	
		
		addr = 'd123;
		
		@(posedge data_strob);
		
		@(posedge clk);
		
		addr = 'd144;
		
		@(posedge data_strob);
		
		@(posedge clk);
		
		addr = 'd169;
		read = 1'b0;
		write = 1'b1;
		write_data = 14;
		
		repeat (20) @(posedge clk);

		addr = 'd180;
		read = 1'b1;
		write = 1'b0;
		
		@(posedge data_strob);
		
		@(posedge clk);
		
		addr = 'd200;
		read = 1'b0;
		write = 1'b1;
		write_data = 9;

		repeat (20) @(posedge clk);
		
		$writememh("D:/SIFO/Lab8/ram_final.hex", lab8_dut.ram_dut.mem);
		
		$stop;
		
	end

endmodule