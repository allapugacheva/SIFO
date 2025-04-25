module predicter (
	input        clk,
	input        rst,
	input  [1:0] state,
	input        predict_req,
	output logic predict,
	output logic predict_strob
);
	
	assign predict = state[1] & predict_strob; 
	assign predict_strob = work_cnt == 2'd3;
	
	logic [1:0] work_cnt;
	
	always_ff @(posedge clk or posedge rst) begin
		if (rst)
			work_cnt <= '0;
		else if (predict_req | (work_cnt != '0 & ~predict_req))
			work_cnt <= work_cnt + 1'b1;
	end
	
endmodule