module fertilising_controller (
    output fertilising,
    output cleaning,
    output alarm,

    input low_level,
    input empty_tank,
    input splinker,
    input fertilise_push,
	input clock,
	input reset
);

	reg state, next_state;

	parameter IDLE = 0;
	parameter FERTILISE = 1;

	assign condition_of_fertilisation = !low_level & splinker;

	always @(posedge clock, posedge reset)
	if (reset) state <= IDLE;
	else state <= next_state;

	always @(*)
	case (state)
		IDLE:
			if (condition_of_fertilisation & fertilise_push) next_state <= FERTILISE;
			else next_state <= IDLE;
		FERTILISE:
			if (empty_tank) next_state <= IDLE;
			else next_state <= FERTILISE;
	endcase

	assign fertilising = (state == FERTILISE) & !alarm;
	assign alarm = (!condition_of_fertilisation & fertilise_push);
	assign cleaning = (state == FERTILISE) & !condition_of_fertilisation & !alarm;

endmodule