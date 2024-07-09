module main(
	input low_water_level,
	input mid_water_level,
	input high_water_level,

	input earth_humidity,
	input air_humidity,
	input low_temperature,

	input selector,
	input clock,
	input pulse_3,
	input pulse_2,

	// LED RGB
	output alarm,

	// Array of LEDs Display
	output water_supply_valvule_indicator,
	output counter_2,
	output counter_1,
	output counter_0,
	output splinker_bomb,
	output dripper_valvule,

	// 7-Segment Display
	output segment_a, output segment_b, output segment_c,
    output segment_d, output segment_e, output segment_f,
    output segment_g,

	output display_0, output display_1,
	output display_2, output display_3,
	output displays_point,

	// Matrix of LEDs Display
	output matrix_col_0, output matrix_col_1, output matrix_col_2,
	output matrix_col_3, output matrix_col_4,

	output matrix_row_0, output matrix_row_1, output matrix_row_2,
	output matrix_row_3, output matrix_row_4, output matrix_row_5,
	output matrix_row_6

);

	//-------------------------------------------
	// Input & Error Checking
	//-------------------------------------------

	water_sensors_checker check_error(
		conflicting_values,

		low_water_level,
		mid_water_level,
		high_water_level
	);


	//-------------------------------------------
	// Irrigation Controller and Selector
	//-------------------------------------------

	irrigation_controller check_prerequisites(
		irrigation_on,

		conflicting_values,
		earth_humidity,
		low_water_level
	);

	irrigation_selector select_irrigation(
		splinker_mode_on,

		air_humidity,
		low_temperature,
		mid_water_level
	);

	not (dripper_mode_on, splinker_mode_on);

	// Output
	and open_splinker(
		splinker_bomb,

		splinker_mode_on,
		irrigation_on
	);

	// Output
	and open_dripper(
		dripper_valvule,

		dripper_mode_on,
		irrigation_on
	);


	//-------------------------------------------
	// Alarm Output
	//-------------------------------------------

	// Output
	alarm_controller enable_alarm(
		alarm,

		mid_water_level,
		conflicting_values
	);


	//-------------------------------------------
	// Encoders
	//-------------------------------------------

	wire [1:0] encoded_water;

	water_encoder encode_water(
		encoded_water,

		high_water_level,
		mid_water_level,
		low_water_level
	);


	//-------------------------------------------
	// Matrix Display
	//-------------------------------------------

	wire [2:0] ring_counting;

	// Clock reduction

	clock_divisor (reduced_clock_1, clock, 1);
	clock_divisor (reduced_clock, reduced_clock_1, 1);

	clock_divisor (reduced_clock_2, reduced_clock, 1);
	clock_divisor (reduced_clock_3, reduced_clock_2, 1);
	clock_divisor (reduced_clock_4, reduced_clock_3, 1);


	// Ring Counter

	column_selector select_column(ring_counting, reduced_clock, pulse_3);

	// Matrix Columns decoders

	wire [6:0] water_column_1;
	wire [6:0] water_column_0;

	water_level_decoder decode_water_level_to_matrix(
	   	water_column_1,
	   	water_column_0,

		encoded_water,
		conflicting_values
	);

	wire [6:0] irrigation_column_2;
	wire [6:0] irrigation_column_1;
	wire [6:0] irrigation_column_0;

	irrigation_mode_decoder decode_irrigation_mode_to_matrix(
		irrigation_column_2,
		irrigation_column_1,
		irrigation_column_0,

		splinker_mode_on,
		irrigation_on
	);

	// Matrix Sync

	wire [6:0] synced_column_2;
	wire [6:0] synced_column_1;
	wire [6:0] synced_column_0;

	select_matrix_display_mode select_display_mode(
		synced_column_2,
		synced_column_1,
		synced_column_0,

		reduced_clock_4,

		water_column_1,
		water_column_0,
		water_column_0,

		irrigation_column_2,
		irrigation_column_1,
		irrigation_column_0
	);

	matrix_ring_decoder decode_ring(
		matrix_col_0,
		matrix_col_1,
		matrix_col_2,
		matrix_col_3,
		matrix_col_4,

		ring_counting
	);

	matrix_driver drive_matrix(
		matrix_row_0,
		matrix_row_1,
		matrix_row_2,
		matrix_row_3,
		matrix_row_4,
		matrix_row_5,
		matrix_row_6,

		ring_counting,

		synced_column_2,
		synced_column_1,
		synced_column_0
	);

	//-------------------------------------------
	// 7-Segments Display
	//-------------------------------------------

	wire [3:0] displays_data;

	wire [3:0] selected_display;
    wire [3:0] data_3;
    wire [3:0] data_2;
    wire [3:0] data_1;
    wire [3:0] data_0;

    wire [3:0] minutes_d;
	wire [3:0] minutes_u;
	wire [3:0] seconds_d;

	wire [3:0] water_supply_valvule;

	display_selector (selected_display, reduced_clock, pulse_3);

	not (display_3, selected_display[3]);
	not (display_2, selected_display[2]);
	not (display_1, selected_display[1]);
	not (display_0, selected_display[0]);

    water_supply_controller (water_supply_valvule, conflicting_values, high_water_level);
	not (water_supply_valvule_indicator, water_supply_valvule[0]);

	wire [3:0] minutes_u_setter;
	wire [3:0] minutes_d_setter;

	wire [3:0] minutes_u_resetter;
	wire [3:0] seconds_d_resetter;
	wire [3:0] minutes_d_resetter;

	level_to_pulse(splinker_pulse, splinker_mode_on, reduced_clock_4);
	level_to_pulse(dripper_pulse, dripper_mode_on, reduced_clock_4);

	or (irrigation_switch_pulse, splinker_pulse, dripper_pulse);

	timer_reseter (
		reset_count,

		irrigation_switch_pulse,
		pulse_2,
		irrigation_on,
		conflicting_values,

		minutes_d,
		minutes_u,
		seconds_d
	);

	set_display_init(
		minutes_d_setter,
		minutes_u_setter,

		minutes_d_resetter,
		minutes_u_resetter,
		seconds_d_resetter,

		reset_count,
		splinker_mode_on
	);

	// When Reset, or when 0 and clock
	//
	//	        INPUT		    OUTPUT
	//  --------------------  ----------
	//	Recount  Not 0 Clock  Next State
	//  ------- ------ -----  ----------
	//     0      0      0        0
	//     0      0      1        0
	//     0      1      0        0
	//     0      1      1        1
	//     1      0      0        1
	//     1      0      1        1
	//     1      1      0        1
	//     1      1      1        1
	//
	//    Y = Number * Clock + Recount

	or (
        not_zero,
		seconds_d[2], seconds_d[1], seconds_d[0],
		minutes_u[3], minutes_u[2], minutes_u[1], minutes_u[0],
		minutes_d[1], minutes_d[0]
    );

	and (displays_clock_term_1, not_zero, reduced_clock_4);
	or  (counters_clock, displays_clock_term_1);


	//						OUTPUT								       INPUT
	//			 ----------------------------- -------------------------------------------------------
	//			   Value       Trigger-Next	        Setter             Resetter         Next-State
	//			 ---------- ------------------ ----------------- ------------------- -----------------
	down_from_5 (seconds_d, trigger_minutes_u,                   seconds_d_resetter, counters_clock);
	down_from_9 (minutes_u, trigger_minutes_d, minutes_u_setter, minutes_u_resetter, trigger_minutes_u);
	down_from_3 (minutes_d, 				   minutes_d_setter, minutes_d_resetter, trigger_minutes_d);

    error_or_info (data_3, conflicting_values, water_supply_valvule, 4'b1011);
    error_or_info (data_2, conflicting_values, minutes_d, 4'b1100);
    error_or_info (data_1, conflicting_values, minutes_u, 4'b1100);
    error_or_info (data_0, conflicting_values, seconds_d, 4'b1101);

	display_driver (
		displays_data,

		selected_display,

		data_3,
		data_2,
		data_1,
		data_0
	);

	display_decoder (
		segment_a, segment_b, segment_c,
		segment_d, segment_e, segment_f, segment_g,

		displays_data
	);

	nor (display_1_not_selected, selected_display[1]);
	or  (displays_point, display_1_not_selected, conflicting_values);

endmodule
