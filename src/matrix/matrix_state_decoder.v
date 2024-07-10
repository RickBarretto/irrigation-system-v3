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
            empty: begin
                assign column_4 = 7'b1111111;
                assign column_3 = 7'b1111111;
                assign column_2 = 7'b1111111;
                assign column_1 = 7'b1111111;
                assign column_0 = 7'b1111111;
            end

            filling: begin
                assign column_4 = 7'b1101111;
                assign column_3 = 7'b1011111;
                assign column_2 = 7'b0000000;
                assign column_1 = 7'b1011111;
                assign column_0 = 7'b1101111;
            end

            cleaning: begin
                assign column_4 = 7'b1111111;
                assign column_3 = 7'b0000110;
                assign column_2 = 7'b0000000;
                assign column_1 = 7'b0000110;
                assign column_0 = 7'b1111111;
            end

            fertilising: begin
                assign column_4 = 7'b1111111;
                assign column_3 = 7'b1100110;
                assign column_2 = 7'b1000000;
                assign column_1 = 7'b1000110;
                assign column_0 = 7'b0011111;
            end

            error: begin
                assign column_4 = 7'b1100011;
                assign column_3 = 7'b1001101;
                assign column_2 = 7'b1010101;
                assign column_1 = 7'b1011001;
                assign column_0 = 7'b1100011;
            end

            splinker: begin
                assign column_4 = 7'b1001110;
                assign column_3 = 7'b0111100;
                assign column_2 = 7'b0000000;
                assign column_1 = 7'b0111100;
                assign column_0 = 7'b1001110;
            end

            dripper: begin
                assign column_4 = 7'b1111001;
                assign column_3 = 7'b1100000;
                assign column_2 = 7'b1000000;
                assign column_1 = 7'b1100000;
                assign column_0 = 7'b1111001;
            end

            default: begin
                assign column_4 = 7'b1111111;
                assign column_3 = 7'b1111111;
                assign column_2 = 7'b1111111;
                assign column_1 = 7'b1111111;
                assign column_0 = 7'b1111111;
            end
        endcase
    end

endmodule