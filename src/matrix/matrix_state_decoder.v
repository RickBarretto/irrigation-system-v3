module matrix_state_decoder(
    output [2:0] state,

    input filling,
    input cleaning,
    input input_error,
    input splinker,
    input dripper
);

    wire [2:0] irrigation_state;
    assign irrigation_state[2] = dripper;
    assign irrigation_state[1] = splinker;
    assign irrigation_state[0] = irrigation_state[1];

    wire [2:0] other_states;
    assign other_states[0] = cleaning;
    assign other_states[1] = input_error;

    assign state = (dripper | splinker)? (irrigation_state) : (other_states);

endmodule

module matrix_image_selector (
    output reg [6:0] column_4,
    output reg [6:0] column_3,
    output reg [6:0] column_2,
    output reg [6:0] column_1,
    output reg [6:0] column_0,

    input [2:0] state
);

    parameter filling     = 3'b000;
    parameter cleaning    = 3'b001;
    parameter error       = 3'b010;
    parameter splinker    = 3'b011;
    parameter dripper     = 3'b100;

    always @(*) begin
        case (state)
            filling: begin
                column_4 <= 7'b1111011; 
                column_3 <= 7'b1111101; 
                column_2 <= 7'b0000000;
                column_1 <= column_3;
                column_0 <= column_4;
				end
            cleaning: begin
                column_4 <= 7'b1111111;  
                column_3 <= 7'b0110000; 
                column_2 <= 7'b0000000; 
                column_1 <= column_3;
                column_0 <= column_4;
				end
            error: begin
                column_4 <= 7'b1100011; 
                column_3 <= 7'b1011001; 
                column_2 <= 7'b1010101; 
                column_1 <= 7'b1001101; 
                column_0 <= column_4;
				end
            splinker: begin
                column_4 <= 7'b0111001; 
                column_3 <= 7'b0011110; 
                column_2 <= 7'b0000000; 
                column_1 <= column_3;
                column_0 <= column_4;
				end
            dripper: begin
                column_4 <= 7'b1001111; 
                column_3 <= 7'b0000011; 
                column_2 <= 7'b0000001; 
                column_1 <= column_3;
                column_0 <= column_4;
				end
            default: begin
                column_4 <= 7'b1111111; 
                column_3 <= column_4;
                column_2 <= column_4;
                column_1 <= column_4;
                column_0 <= column_4;
				end
        endcase
    end

endmodule