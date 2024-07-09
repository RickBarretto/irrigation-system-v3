module tank_cleaning_decoder (
    output [6:0] column_1, // 3 & 1
    output [6:0] column_0  // 2
);

    assign column_1 = 7'b0000110;
    assign column_0 = 7'b0000000;

endmodule