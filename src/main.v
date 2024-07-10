module main(
    output matrix_col_4,
    output matrix_col_3,
    output matrix_col_2,
    output matrix_col_1,
    output matrix_col_0,

    output matrix_row_6,
    output matrix_row_5,
    output matrix_row_4,
    output matrix_row_3,
    output matrix_row_2,
    output matrix_row_1,
    output matrix_row_0,

    input clock,

    input selector,
    input water_2,
    input water_1,
    input water_0,
    input state_2,
    input state_1,
    input state_0
);


    // Setting the final clock
    // -----------------------

    // Fast clock is used by the matrix's and 7-segment display's driver
    // Slow clock is used by the counter and image alternation
    clock_definer set_default_clock(
        fast_clock,
        slow_clock,

        clock
    );


    // Matrix images
    // -------------

    wire [6:0] column_4, column_3, column_2, column_1, column_0;
    wire [6:0] selected_matrix_column;

    matrix_alternate_display_mode (
        column_4, column_3,
        column_2, column_1,
        column_0,

        current_state, // 3 bits
        water_level,   // 3 bits

        selector
    );

    matrix_column_selector (
        {matrix_row_6, matrix_row_5, matrix_row_4, matrix_row_3, matrix_row_2, matrix_row_1, matrix_row_0},
        {matrix_col_4, matrix_col_3, matrix_col_2, matrix_col_1, matrix_col_0},

        column_4,
        column_3,
        column_2,
        column_1,
        column_0,

        fast_clock,
        0
    );






endmodule