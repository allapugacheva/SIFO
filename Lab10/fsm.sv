module fsm (
	input              result,
	input              result_strob,
	input        [1:0] state,
	output logic [1:0] new_state
);

	always_comb begin
		new_state = state;
		
		if (result_strob)
			case (state)
				2'd0: if ( result) new_state = 2'd1;
				2'd1: if ( result) new_state = 2'd3;
						else         new_state = 2'd0;
				2'd2: if ( result) new_state = 2'd3;
						else         new_state = 2'd0;
				2'd3: if (~result) new_state = 2'd2;
			endcase
	end

endmodule