module adubation_decoder (
    output [6:0] column_4,
    output [6:0] column_3,
    output [6:0] column_2,
    output [6:0] column_1,
    output [6:0] column_0
);

    assign column_4 = 7'b1111111;
    assign column_3 = 7'b1100110;
    assign column_2 = 7'b1000000;
    assign column_1 = 7'b1000110;
    assign column_0 = 7'b0011111;

endmodule