module clock_definer(
    output fast_clock,
    output slow_clock,

    input clock
);

    //                  OUTPUT           INPUT      RESET
    //             ---------------  --------------- -----
    clock_divisor (reduced_clock_1,      clock,       1  );
	clock_divisor (fast_clock,      reduced_clock_1,  1  );

	clock_divisor (reduced_clock_2,   fast_clock,     1  );
	clock_divisor (reduced_clock_3, reduced_clock_2,  1  );
	clock_divisor (slow_clock,      reduced_clock_3,  1  );

endmodule