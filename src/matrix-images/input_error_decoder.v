module input_error_decoder (
    output [6:0] column_4,
    output [6:0] column_3,
    output [6:0] column_2,
    output [6:0] column_1,
    output [6:0] column_0
);

    assign column_4 = 7'b1100011;
    assign column_3 = 7'b1001101;
    assign column_2 = 7'b1010101;
    assign column_1 = 7'b1011001;
    assign column_0 = 7'b1100011;

endmodule