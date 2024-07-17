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

    output fertilising,
    output cleaning,
    output alarm,

    input clock,

    input splinker_switch,
    input dripper_switch,

    input fertilise_button,
	input reset_button
);

    not (fertilise_push, fertilise_button);
    not (reset_pulse, reset_button);

    // Setting the final clock
    // -----------------------

    // Fast clock is used by the matrix's and 7-segment display's driver
    // Slow clock is used by the counter and image alternation
    clock_definer set_default_clock(
        fast_clock,
        slow_clock,

        clock
    );

    // Setting the FSM
    // ---------------

    wire [3:0] water_level;

    check_irrigation(
        irrigation_allowed,
        input_error,

        dripper_switch,
        splinker_switch
    );


    // Tank Level

    assign full_tank = water_level[2] & water_level[1] & water_level[0];
    assign critical_tank_level = ~water_level[0] & ~water_level[1]; // 001 or 000
    assign empty_tank = ~(water_level[2] & water_level[1] & water_level[0]);

    check_watering_condition(
        watering_condition,

        full_tank,
        input_error
    );

    check_filling_condition(
        filling_condition,

        critical_tank_level,
        fertilising,
        cleaning
    );

    water_level_clock_controller(
        water_level_clock,

        dripper,
        slow_clock
    );

    water_level_controller(
        water_level,

        watering,
        water_level_clock,
        reset_pulse
    );

    water_tank_fsm(
        watering,
        filling,

        fast_clock,
        reset_pulse,

        watering_condition,
        filling_condition
    );

    assign reset_irrigation = full_tank | reset_pulse;

    irrigation_fsm(
        splinker,
        dripper,

        fast_clock,
        reset_irrigation,

        watering,
        splinker_switch,
        dripper_switch
    );

    fertilising_controller(
        fertilising,
        cleaning,
        alarm,

        critical_tank_level,
        empty_tank,
        splinker,
        fertilise_push
    );


    // Matrix images
    // -------------

    wire [6:0] column_4, column_3, column_2, column_1, column_0;
    wire [6:0] selected_matrix_column;

    matrix_alternate_display_mode (
        column_4, column_3,
        column_2, column_1,
        column_0,

        {state_2, state_1, state_0}, // 3 bits
        water_level, // 3 bits

        slow_clock
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
        reset_pulse
    );


endmodule