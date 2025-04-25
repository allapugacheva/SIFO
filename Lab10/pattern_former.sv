module pattern_former # (
	parameter PATTERN_WIDTH = 4
) (
	input                        clk,
	input                        rst,
	input                        result,
	input                        result_strob,
	output [PATTERN_WIDTH - 1:0] pattern
);

	logic [PATTERN_WIDTH - 1:0] ghr;
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			ghr <= '0;
		else if (result_strob)
			ghr <= { ghr[PATTERN_WIDTH - 2:0], result };
	end
	
	assign pattern = ghr;

endmodule
				 