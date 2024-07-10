module tank_empting_decoder (
    output [6:0] column_level, // all columns

    // 3bits encoded counter
    input [2:0] water_level
);

    always @(*) begin
        case (water_level)
            3'b000:  column_level <= 7'b1111111;
            3'b001:  column_level <= 7'b1111110;
            3'b010:  column_level <= 7'b1111100;
            3'b011:  column_level <= 7'b1111000;
            3'b100:  column_level <= 7'b1110000;
            3'b101:  column_level <= 7'b1100000;
            3'b110:  column_level <= 7'b1000000;
            3'b111:  column_level <= 7'b0000000;
            default: column_level <= 7'b1111111;
        endcase
    end

endmodule