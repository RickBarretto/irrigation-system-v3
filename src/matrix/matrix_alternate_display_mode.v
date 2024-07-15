module matrix_alternate_display_mode (
    output [6:0] column_4,
    output [6:0] column_3,
    output [6:0] column_2,
    output [6:0] column_1,
    output [6:0] column_0,

    input [2:0] current_state,
    input [2:0] water_level,

    input selector
);

    wire [6:0] state_col_4, state_col_3, state_col_2, state_col_1, state_col_0;
    wire [6:0] water_col;

    matrix_image_selector(
        state_col_4,
        state_col_3,
        state_col_2,
        state_col_1,
        state_col_0,

        current_state
    );

    tank_empting_decoder (
        water_col,
        water_level
    );

    assign column_4 = (selector)? (state_col_4) : (water_col);
    assign column_3 = (selector)? (state_col_3) : (water_col);
    assign column_2 = (selector)? (state_col_2) : (water_col);
    assign column_1 = (selector)? (state_col_1) : (water_col);
    assign column_0 = (selector)? (state_col_0) : (water_col);


endmodule