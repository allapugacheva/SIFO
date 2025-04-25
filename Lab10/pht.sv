module pht # (
	parameter PATTERN_WIDTH = 4
) (
	input                        clk,
	input                        rst,
	input  [PATTERN_WIDTH - 1:0] pattern,
	input  [1:0]                 new_state,
	input                        result_strob,
	output [1:0]                 state,
	
	output [1:0]                 pht_reg0,
	output [1:0]                 pht_reg1,
	output [1:0]                 pht_reg2,
	output [1:0]                 pht_reg3,
	output [1:0]                 pht_reg4,
	output [1:0]                 pht_reg5,
	output [1:0]                 pht_reg6,
	output [1:0]                 pht_reg7,
	output [1:0]                 pht_reg8,
	output [1:0]                 pht_reg9,
	output [1:0]                 pht_reg10,
	output [1:0]                 pht_reg11,
	output [1:0]                 pht_reg12,
	output [1:0]                 pht_reg13,
	output [1:0]                 pht_reg14,
	output [1:0]                 pht_reg15
);

	logic [PATTERN_WIDTH ** 2 - 1:0][1:0] data;
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			for (int i = 0; i < PATTERN_WIDTH ** 2; i++)
				data[i] <= '0;
		else if (result_strob)
			data[pattern] <= new_state;
	end
	
	assign state = data[pattern];
	
	assign pht_reg0  = data[0];
	assign pht_reg1  = data[1];
	assign pht_reg2  = data[2];
	assign pht_reg3  = data[3];
	assign pht_reg4  = data[4];
	assign pht_reg5  = data[5];
	assign pht_reg6  = data[6];
	assign pht_reg7  = data[7];
	assign pht_reg8  = data[8];
	assign pht_reg9  = data[9];
	assign pht_reg10 = data[10];
	assign pht_reg11 = data[11];
	assign pht_reg12 = data[12];
	assign pht_reg13 = data[13];
	assign pht_reg14 = data[14];
	assign pht_reg15 = data[15];

endmodule