//! Matrix Ring's Decoder is a 3x5 decoder
//!
//! This module creates the logic of mirror the image on the Y-axis.
module matrix_ring_decoder(
    output column_0,
	output column_1,
	output column_2,
	output column_3,
	output column_4,

    input [2:0] ring_counter
);

	pipe (column_0, ring_counter[2]);
	pipe (column_1, ring_counter[1]);
	pipe (column_2, ring_counter[0]);
    pipe (column_3, ring_counter[1]);
	pipe (column_4, ring_counter[2]);


endmodule