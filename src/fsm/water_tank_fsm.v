module check_irrigation(
    output irrigation,
    output error,

    input dripper,
    input splinker
);

    xor (irrigation, splinker, dripper);
    and (error, splinker, dripper);

endmodule

module check_watering_condition(
    output watering_condition,

    input full_tank,
    input dripper,
	 input splinker
);

    assign watering_condition =  (full_tank & ~splinker & dripper) | (full_tank & splinker & ~dripper);

endmodule

module water_tank_fsm (
    output watering,
    output filling,

    input clock,
    input reset,

    input watering_condition,
    input filling_condition
);

    reg [1:0] state, next_state;

    parameter IDLE = 2'b00;
    parameter WATERING = 2'b01;
    parameter FILLING = 2'b10;

    always @(posedge clock, posedge reset)
        if ( reset ) state <= IDLE;
        else     	 state <= next_state;

    always @(*)
    case (state)
        IDLE:
            if (filling_condition) next_state <= FILLING;
            else begin
                if (watering_condition) next_state <= WATERING;
                else next_state <= IDLE;
            end
        WATERING:
            if (filling_condition) next_state <= FILLING;
            else next_state <= WATERING;
        FILLING:
            if (watering_condition) next_state <= IDLE;
            else next_state <= FILLING;
        default:
            next_state <= IDLE;
    endcase

    assign watering = (state == WATERING);
    assign filling = (state == FILLING);

endmodule