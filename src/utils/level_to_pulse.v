module level_to_pulse (
    output pulse,

    input level,
    input clock
);

    flipflop_d(q, clock, , , level);
    not (not_q, q);
    and (pulse, not_q, level);

endmodule