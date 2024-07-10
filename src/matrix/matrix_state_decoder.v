module matrix_image_selector (
    output [6:0] column_4,
    output [6:0] column_3,
    output [6:0] column_2,
    output [6:0] column_1,
    output [6:0] column_0,

    input [2:0] state
);

    parameter empty       = 3'b000;
    parameter filling     = 3'b001;
    parameter cleaning    = 3'b010;
    parameter fertilising = 3'b011;
    parameter error       = 3'b100;
    parameter splinker    = 3'b101;
    parameter dripper     = 3'b110;

    always @(*) begin
        case (state)
            empty:
                column_4 <= 7'b1111111;
                column_3 <= 7'b1111111;
                column_2 <= 7'b1111111;
                column_1 <= 7'b1111111;
                column_0 <= 7'b1111111;
            filling:
                column_4 <= 7'b1101111;
                column_3 <= 7'b1011111;
                column_2 <= 7'b0000000;
                column_1 <= column_3;
                column_0 <= column_4;
            cleaning:
                column_4 <= 7'b1111111;
                column_3 <= 7'b0000110;
                column_2 <= 7'b0000000;
                column_1 <= column_3;
                column_0 <= column_4;
            fertilising:
                column_4 <= 7'b1111111;
                column_3 <= 7'b1100110;
                column_2 <= 7'b1000000;
                column_1 <= 7'b1000110;
                column_0 <= 7'b0011111;
            error:
                column_4 <= 7'b1100011;
                column_3 <= 7'b1001101;
                column_2 <= 7'b1010101;
                column_1 <= 7'b1011001;
                column_0 <= column_4;
            splinker:
                column_4 <= 7'b1001110;
                column_3 <= 7'b0111100;
                column_2 <= 7'b0000000;
                column_1 <= column_3;
                column_0 <= column_4;
            dripper:
                column_4 <= 7'b1111001;
                column_3 <= 7'b1100000;
                column_2 <= 7'b1000000;
                column_1 <= column_3;
                column_0 <= column_4;
            default:
                column_4 <= 7'b1111111;
                column_3 <= 7'b1111111;
                column_2 <= 7'b1111111;
                column_1 <= 7'b1111111;
                column_0 <= 7'b1111111;
        endcase
    end

endmodule