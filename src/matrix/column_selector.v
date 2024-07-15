//! Column Selector is a 3 bit Ring Counter
//!
//! The reason why we just need 3 bits for a 5 columns lenght matrix
//! is the fact of the images being mirrored,
//! so 2 of those columns are exactly the same.
module column_selector (output [4:0] col, input clock, input reset);

    //              Q     clock  set reset   D
    //            ------- ------ --- ----- ------
	flipflop_d1 D4(col[4], clock,  reset,   0,  col[0]);
	flipflop_d D3(col[3], clock,  0,   reset,  col[1]);
    flipflop_d D2(col[2], clock,  0,   reset,  col[2]);
    flipflop_d D1(col[1], clock,  0,   reset,  col[3]);
    flipflop_d D0(col[0], clock,  0 ,  reset,  col[4]);

endmodule