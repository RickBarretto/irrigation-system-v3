module clock_divisor(
    output new_frequency,

    input clock,
    input reset
);

    flipflop_t (wire_1,   clock,  reset, 1);
    flipflop_t (wire_2,  wire_1,  reset, 1);
    flipflop_t (wire_3,  wire_2,  reset, 1);
    flipflop_t (wire_4,  wire_3,  reset, 1);

    flipflop_t (new_frequency, wire_4, reset, 1);

endmodule