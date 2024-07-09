module down_from_3 (
    output [1:0] q_bus,

    input [1:0] set,
    input [1:0] reset,

    input clock
);

    //! Image Present  Next  d1 d0
    //! ----- ------- ------ -- --
    //!   3     11      10   1  0
    //!   2     10      01   0  1
    //!   1     01      00   0  0
    //!   0     00      11   1  1

    wire [1:0] d_bus;

    // d1 = q1'q0' + q1q0
    nor (d1_term_1, q_bus[1], q_bus[0]);
    and (d1_term_2, q_bus[1], q_bus[0]);
    or  (d_bus[1], d1_term_1, d1_term_2);

    // d0 = q0'
    not (d_bus[0], q_bus[0]);

    flipflop_d (q_bus[1], clock, set[1], reset[1], d_bus[1]);
    flipflop_d (q_bus[0], clock, set[0], reset[0], d_bus[0]);

endmodule