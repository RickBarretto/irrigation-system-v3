module down_from_5 (
    output [2:0] q_bus,
    output trigger_next,

    input [2:0] reset,

    input clock
);

    //! Image Present  Next   d2 d1 d0
    //! ----- ------- ------  -- -- --
    //!   5     101    100    1  0  0
    //!   4     100    011    0  1  1
    //!   3     011    010    0  1  0
    //!   2     010    001    0  0  1
    //!   1     001    000    0  0  0
    //!   0     000    101    1  0  1

    wire [2:0] q_neg_bus;
    wire [2:0] d_bus;
    wire [2:0] set;

    not(q_neg_bus[2], q_bus[2]);
    not(q_neg_bus[1], q_bus[1]);
    not(q_neg_bus[0], q_bus[0]);

    // d2 = q2'q1'q0' + q2q0
    nor (d1_term_1, q_bus[2], q_bus[1], q_bus[0]);
    and (d1_term_2, q_bus[2], q_bus[0]);
    or  (d_bus[2], d1_term_1, d1_term_2);

    // d1 = q1q0 + q2q0'
    and (d2_term_1, q_bus[1], q_bus[0]);
    and (d2_term_2, q_bus[2], q_neg_bus[0]);
    or  (d_bus[1], d2_term_1, d2_term_2);

    // d0 = q0'
    not (d_bus[0], q_bus[0]);

    flipflop_d (q_bus[2], clock, set[2], reset[2], d_bus[2]);
    flipflop_d (q_bus[1], clock, set[1], reset[1], d_bus[1]);
    flipflop_d (q_bus[0], clock, set[0], reset[0], d_bus[0]);

    and when_5(trigger_next, q_bus[2], q_bus[0]);

endmodule