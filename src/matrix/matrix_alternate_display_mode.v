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

    multiplexer_2x1(column_4[6], state_col_4[6], water_col[6], selector);
    multiplexer_2x1(column_4[5], state_col_4[5], water_col[5], selector);
    multiplexer_2x1(column_4[4], state_col_4[4], water_col[4], selector);
    multiplexer_2x1(column_4[3], state_col_4[3], water_col[3], selector);
    multiplexer_2x1(column_4[2], state_col_4[2], water_col[2], selector);
    multiplexer_2x1(column_4[1], state_col_4[1], water_col[1], selector);
    multiplexer_2x1(column_4[0], state_col_4[0], water_col[0], selector);

    multiplexer_2x1(column_3[6], state_col_3[6], water_col[6], selector);
    multiplexer_2x1(column_3[5], state_col_3[5], water_col[5], selector);
    multiplexer_2x1(column_3[4], state_col_3[4], water_col[4], selector);
    multiplexer_2x1(column_3[3], state_col_3[3], water_col[3], selector);
    multiplexer_2x1(column_3[2], state_col_3[2], water_col[2], selector);
    multiplexer_2x1(column_3[1], state_col_3[1], water_col[1], selector);
    multiplexer_2x1(column_3[0], state_col_3[0], water_col[0], selector);

    multiplexer_2x1(column_2[6], state_col_2[6], water_col[6], selector);
    multiplexer_2x1(column_2[5], state_col_2[5], water_col[5], selector);
    multiplexer_2x1(column_2[4], state_col_2[4], water_col[4], selector);
    multiplexer_2x1(column_2[3], state_col_2[3], water_col[3], selector);
    multiplexer_2x1(column_2[2], state_col_2[2], water_col[2], selector);
    multiplexer_2x1(column_2[1], state_col_2[1], water_col[1], selector);
    multiplexer_2x1(column_2[0], state_col_2[0], water_col[0], selector);

    multiplexer_2x1(column_1[6], state_col_1[6], water_col[6], selector);
    multiplexer_2x1(column_1[5], state_col_1[5], water_col[5], selector);
    multiplexer_2x1(column_1[4], state_col_1[4], water_col[4], selector);
    multiplexer_2x1(column_1[3], state_col_1[3], water_col[3], selector);
    multiplexer_2x1(column_1[2], state_col_1[2], water_col[2], selector);
    multiplexer_2x1(column_1[1], state_col_1[1], water_col[1], selector);
    multiplexer_2x1(column_1[0], state_col_1[0], water_col[0], selector);

    multiplexer_2x1(column_0[6], state_col_0[6], water_col[6], selector);
    multiplexer_2x1(column_0[5], state_col_0[5], water_col[5], selector);
    multiplexer_2x1(column_0[4], state_col_0[4], water_col[4], selector);
    multiplexer_2x1(column_0[3], state_col_0[3], water_col[3], selector);
    multiplexer_2x1(column_0[2], state_col_0[2], water_col[2], selector);
    multiplexer_2x1(column_0[1], state_col_0[1], water_col[1], selector);
    multiplexer_2x1(column_0[0], state_col_0[0], water_col[0], selector);

    // always @(*) begin

    //     if (selector) begin
    //         column_4 <= state_col_4;
    //         column_3 <= state_col_3;
    //         column_2 <= state_col_2;
    //         column_1 <= state_col_1;
    //         column_0 <= state_col_0;
    //     end

    //     else begin
    //         column_4 <= water_col;
    //         column_3 <= water_col;
    //         column_2 <= water_col;
    //         column_1 <= water_col;
    //         column_0 <= water_col;
    //     end

    // end


endmodule