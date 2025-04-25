module lab10 # (
	parameter PATTERN_WIDTH = 4
) (
	input                        clk,
	input                        rst,
	input                        predict_req,
	input                        result,
	input                        result_strob,
	output                       predict,
	output                       predict_strob,
	output [PATTERN_WIDTH - 1:0] pattern,
	output [1:0]                 state,
	output [1:0]                 new_state,
	output [1:0]                 pht0,
	output [1:0]                 pht1,
	output [1:0]                 pht2,
	output [1:0]                 pht3,
	output [1:0]                 pht4,
	output [1:0]                 pht5,
	output [1:0]                 pht6,
	output [1:0]                 pht7,
	output [1:0]                 pht8,
	output [1:0]                 pht9,
	output [1:0]                 pht10,
	output [1:0]                 pht11,
	output [1:0]                 pht12,
	output [1:0]                 pht13,
	output [1:0]                 pht14,
	output [1:0]                 pht15
);

	logic [PATTERN_WIDTH - 1:0] _pattern;
	assign pattern = _pattern;

	pattern_former former_inst(
		.clk          (clk),
		.rst          (rst),
		.result       (result),
		.result_strob (result_strob),
		.pattern      (_pattern)
	);

	logic [1:0] _state, _new_state;
	assign state     = _state;
	assign new_state = _new_state;
	
	pht pht_inst(
		.clk          (clk),
		.rst          (rst),
		.pattern      (_pattern),
		.new_state    (_new_state),
		.result_strob (result_strob),
		.state        (_state),
		.pht_reg0     (pht0),
		.pht_reg1     (pht1),
		.pht_reg2     (pht2),
		.pht_reg3     (pht3),
		.pht_reg4     (pht4),
		.pht_reg5     (pht5),
		.pht_reg6     (pht6),
		.pht_reg7     (pht7),
		.pht_reg8     (pht8),
		.pht_reg9     (pht9),
		.pht_reg10    (pht10),
		.pht_reg11    (pht11),
		.pht_reg12    (pht12),
		.pht_reg13    (pht13),
		.pht_reg14    (pht14),
		.pht_reg15    (pht15)
	);
	
	fsm fsm_inst(
		.result       (result),
		.result_strob (result_strob),
		.state        (_state),
		.new_state    (_new_state)
	);
	
	predicter predicter_inst(
		.clk           (clk),
		.rst           (rst),
		.state         (_state),
		.predict_req   (predict_req),
		.predict       (predict),
		.predict_strob (predict_strob)
	);

endmodule
	