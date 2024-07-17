module water_level_clock_controller(
    output new_clock,

    input dripper,
    input clock
);

    clock_divisor(dripper_clock, clock, 0);
    assign new_clock = (dripper)? (dripper_clock) : clock;

endmodule


module water_level_controller (
    output [2:0] count,

    input upper,
    input clock,
    input reset
);

    reg [2:0] state, next_state;

    always @(posedge clock, posedge reset)
    if (reset) state <= 4'b000;
    else state <= next_state;


    always @(*)
    case (state)
        4'b000:
            if (upper) next_state <= state + 1;
            else next_state <= state;
        4'b111:
            if (!upper) next_state <= state - 1;
            else next_state <= state;
        default:
            if (upper) next_state <= state + 1;
            else next_state <= state - 1;
    endcase

    assign count = state;

endmodule