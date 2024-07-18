module tank_empting_decoder (
    output reg [6:0] column_level, // all columns

    // 3bits encoded counter
    input [2:0] water_level
);

    always @(*) begin
        case (water_level)
            3'b000:  column_level <= 7'b1111111;
            3'b001:  column_level <= 7'b0111111;
            3'b010:  column_level <= 7'b0011111;
            3'b011:  column_level <= 7'b0001111;
            3'b100:  column_level <= 7'b0000111;
            3'b101:  column_level <= 7'b0000011;
            3'b110:  column_level <= 7'b0000001;
            3'b111:  column_level <= 7'b0000000;
            default: column_level <= 7'b1111111;
        endcase
    end

endmodule