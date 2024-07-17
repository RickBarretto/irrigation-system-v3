module matrix_image_selector (
    output reg [6:0] column_4,
    output reg [6:0] column_3,
    output reg [6:0] column_2,
    output reg [6:0] column_1,
    output reg [6:0] column_0,

    input [2:0] state
);

    parameter empty       = 3'b000;
    parameter filling     = 3'b001;
    parameter cleaning    = 3'b010;
    parameter error       = 3'b011;
    parameter splinker    = 3'b100;
    parameter dripper     = 3'b101;

    always @(*) begin
        case (state)
            empty: begin
                column_4 <= 7'b1111111;
                column_3 <= 7'b1111111;
                column_2 <= 7'b1111111;
                column_1 <= 7'b1111111;
                column_0 <= 7'b1111111;
				end
            filling: begin
                column_4 <= 7'b1101111;
                column_3 <= 7'b1011111;
                column_2 <= 7'b0000000;
                column_1 <= column_3;
                column_0 <= column_4;
				end
            cleaning: begin
                column_4 <= 7'b1111111;
                column_3 <= 7'b0000110;
                column_2 <= 7'b0000000;
                column_1 <= column_3;
                column_0 <= column_4;
				end
            error: begin
                column_4 <= 7'b1100011;
                column_3 <= 7'b1001101;
                column_2 <= 7'b1010101;
                column_1 <= 7'b1011001;
                column_0 <= column_4;
				end
            splinker: begin
                column_4 <= 7'b1001110;
                column_3 <= 7'b0111100;
                column_2 <= 7'b0000000;
                column_1 <= column_3;
                column_0 <= column_4;
				end
            dripper: begin
                column_4 <= 7'b1111001;
                column_3 <= 7'b1100000;
                column_2 <= 7'b1000000;
                column_1 <= column_3;
                column_0 <= column_4;
				end
            default: begin
                column_4 <= 7'b1111111;
                column_3 <= 7'b1111111;
                column_2 <= 7'b1111111;
                column_1 <= 7'b1111111;
                column_0 <= 7'b1111111;
				end
        endcase
    end

endmodule