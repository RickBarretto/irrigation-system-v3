//! Select Matrix's Display Mode is a multiplexer that chooses between
//! Irrigation mode display and Water mode display.
//!
//! This changes when the clock, changes.
//!
module select_matrix_display_mode (
	output [6:0] column_2,
	output [6:0] column_1,
	output [6:0] column_0,

	input clock,

	input [6:0] water_col_2,
	input [6:0] water_col_1,
	input [6:0] water_col_0,

	input [6:0] irrigation_col_2,
	input [6:0] irrigation_col_1,
	input [6:0] irrigation_col_0
);

	multiplexer_2x1(column_2[6], water_col_2[6], irrigation_col_2[6], clock);
	multiplexer_2x1(column_2[5], water_col_2[5], irrigation_col_2[5], clock);
	multiplexer_2x1(column_2[4], water_col_2[4], irrigation_col_2[4], clock);
	multiplexer_2x1(column_2[3], water_col_2[3], irrigation_col_2[3], clock);
	multiplexer_2x1(column_2[2], water_col_2[2], irrigation_col_2[2], clock);
	multiplexer_2x1(column_2[1], water_col_2[1], irrigation_col_2[1], clock);
	multiplexer_2x1(column_2[0], water_col_2[0], irrigation_col_2[0], clock);

	multiplexer_2x1(column_1[6], water_col_1[6], irrigation_col_1[6], clock);
	multiplexer_2x1(column_1[5], water_col_1[5], irrigation_col_1[5], clock);
	multiplexer_2x1(column_1[4], water_col_1[4], irrigation_col_1[4], clock);
	multiplexer_2x1(column_1[3], water_col_1[3], irrigation_col_1[3], clock);
	multiplexer_2x1(column_1[2], water_col_1[2], irrigation_col_1[2], clock);
	multiplexer_2x1(column_1[1], water_col_1[1], irrigation_col_1[1], clock);
	multiplexer_2x1(column_1[0], water_col_1[0], irrigation_col_1[0], clock);

	multiplexer_2x1(column_0[6], water_col_0[6], irrigation_col_0[6], clock);
	multiplexer_2x1(column_0[5], water_col_0[5], irrigation_col_0[5], clock);
	multiplexer_2x1(column_0[4], water_col_0[4], irrigation_col_0[4], clock);
	multiplexer_2x1(column_0[3], water_col_0[3], irrigation_col_0[3], clock);
	multiplexer_2x1(column_0[2], water_col_0[2], irrigation_col_0[2], clock);
	multiplexer_2x1(column_0[1], water_col_0[1], irrigation_col_0[1], clock);
	multiplexer_2x1(column_0[0], water_col_0[0], irrigation_col_0[0], clock);

endmodule