module down_from_9 (
    output [3:0] q_bus,
    output trigger_next,

    input [3:0] set,
    input [3:0] reset,

    input clock
);

    //! Image Present  Next   d3 d2 d1 d0
    //! ----- ------- ------  -- -- -- --
    //!   9    1001   1000    1  0  0  0
    //!   8    1000   0111    0  1  1  1
    //!   7    0111   0110    0  1  1  0
    //!   6    0110   0101    0  1  0  1
    //!   5    0101   0100    0  1  0  0
    //!   4    0100   0011    0  0  1  1
    //!   3    0011   0010    0  0  1  0
    //!   2    0010   0001    0  0  0  1
    //!   1    0001   0000    0  0  0  0
    //!   0    0000   1001    1  0  0  1

    wire [3:0] q_neg_bus;
    wire [3:0] d_bus;

    not(q_neg_bus[3], q_bus[3]);
    not(q_neg_bus[2], q_bus[2]);
    not(q_neg_bus[1], q_bus[1]);
    not(q_neg_bus[0], q_bus[0]);

    // d3 = q3'q2'q1'q0' + q3q0
    nor (d3_term_1, q_bus[3], q_bus[2], q_bus[1], q_bus[0]);
    and (d3_term_2, q_bus[3], q_bus[0]);
    or  (d_bus[3], d3_term_1, d3_term_2);

    // d2 = q2q0 + q2q1 + q3q0'
    and (d2_term_1, q_bus[2], q_bus[0]);
    and (d2_term_2, q_bus[2], q_bus[1]);
    and (d2_term_3, q_bus[3], q_neg_bus[0]);
    or  (d_bus[2], d2_term_1, d2_term_2, d2_term_3);

    // d1 = q1q0 + q2q1'q0' + q3q0'
    and (d1_term_1, q_bus[1], q_bus[0]);
    and (d1_term_2, q_bus[2], q_neg_bus[1], q_neg_bus[0]);
    and (d1_term_3, q_bus[3], q_neg_bus[0]);
    or  (d_bus[1], d1_term_1, d1_term_2, d1_term_3);

    // d0 = q0'
    or  (d_bus[0], q_neg_bus[0]);

    flipflop_d (q_bus[3], clock, set[3], reset[3], d_bus[3]);
    flipflop_d (q_bus[2], clock, set[2], reset[2], d_bus[2]);
    flipflop_d (q_bus[1], clock, set[1], reset[1], d_bus[1]);
    flipflop_d (q_bus[0], clock, set[0], reset[0], d_bus[0]);

    and when_9(trigger_next, q_bus[3], q_bus[0]);

endmodule