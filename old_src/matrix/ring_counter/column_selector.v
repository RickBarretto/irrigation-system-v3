//! Column Selector is a 3 bit Ring Counter
//!
//! The reason why we just need 3 bits for a 5 columns lenght matrix
//! is the fact of the images being mirrored,
//! so 2 of those columns are exactly the same.
module column_selector (output [2:0] col, input clock, input pulse);

    not (released, pulse);

    //              Q     clock     set      reset     D
    //            ------- ------ --------- --------- ------
    flipflop_d D2(col[2], clock, released,     0   , col[0]);
    flipflop_d D1(col[1], clock,     0   , released, col[2]);
    flipflop_d D0(col[0], clock,     0   , released, col[1]);

endmodule
