module matrix_column_selector (
    output [6:0] selected_column,
    output [4:0] ring_counter,

    input [6:0] column_4,
    input [6:0] column_3,
    input [6:0] column_2,
    input [6:0] column_1,
    input [6:0] column_0,

    input clock,
    input reset
);

    column_selector(ring_counter, clock, reset);

    assign selected_column =
        (ring_counter[4]) ? (column_4) :
        (ring_counter[3]) ? (column_3) :
        (ring_counter[2]) ? (column_2) :
        (ring_counter[1]) ? (column_1) : (column_0);

endmodule