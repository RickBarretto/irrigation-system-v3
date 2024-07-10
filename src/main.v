module main(
    output matrix_column_4,
    output matrix_column_3,
    output matrix_column_2,
    output matrix_column_1,
    output matrix_column_0,

    output matrix_row_6,
    output matrix_row_5,
    output matrix_row_4,
    output matrix_row_3,
    output matrix_row_2,
    output matrix_row_1,
    output matrix_row_0,

    input clock
);


    // Setting the final clock

    // Fast clock is used by the matrix's and 7-segment display's driver
    // Slow clock is used by the counter and image alternation
    clock_definer set_default_clock(
        fast_clock,
        slow_clock,

        clock
    );


    // Matrix images

    wire [4:0] selected_matrix_column;

    matrix_column_selector (
        selected_matrix_column,
        fast_clock,
        0
    );

    




endmodule