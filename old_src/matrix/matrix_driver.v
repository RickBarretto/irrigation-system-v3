//! Matrix Driver is a multiplexer that syncronizates the rows
//! with the current column of the LED Matrix.
module matrix_driver (
	output row_0,
	output row_1,
	output row_2,
	output row_3,
	output row_4,
	output row_5,
	output row_6,

	input [2:0] ring_counter,

	input [6:0] col_2, //! Columns: 0 & 4
   	input [6:0] col_1, //! Columns: 1 & 3
   	input [6:0] col_0  //! Columns: 2
);

	multiplexer_3x1 (row_0, col_2[6], col_1[6], col_0[6], ring_counter);
	multiplexer_3x1 (row_1, col_2[5], col_1[5], col_0[5], ring_counter);
	multiplexer_3x1 (row_2, col_2[4], col_1[4], col_0[4], ring_counter);
	multiplexer_3x1 (row_3, col_2[3], col_1[3], col_0[3], ring_counter);
	multiplexer_3x1 (row_4, col_2[2], col_1[2], col_0[2], ring_counter);
	multiplexer_3x1 (row_5, col_2[1], col_1[1], col_0[1], ring_counter);
	multiplexer_3x1 (row_6, col_2[0], col_1[0], col_0[0], ring_counter);

endmodule