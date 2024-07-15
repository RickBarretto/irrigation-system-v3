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
            if (!watering_condition & filling_condition) next_state <= FILLING;
            else begin
                if (watering_condition & !filling_condition) next_state <= WATERING;
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