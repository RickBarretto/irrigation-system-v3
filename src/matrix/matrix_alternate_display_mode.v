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

    always @(*) begin
        if (selector)
            column_4 <= state_col_4;
            column_3 <= state_col_3;
            column_2 <= state_col_2;
            column_1 <= state_col_1;
            column_0 <= state_col_0;
        else
            column_4 <= water_col;
            column_3 <= water_col;
            column_2 <= water_col;
            column_1 <= water_col;
            column_0 <= water_col;
    end


endmodule