module irrigation_fsm (
    output splinker,
    output dripper,

    input clock,
    input reset,

    input watering,
    input splinker_switch,
    input dripper_switch
);

    reg [1:0] state, next_state;

    parameter IDLE = 2'b00;
    parameter SPLINKER = 2'b01;
    parameter DRIPPER = 2'b10;

    always @(posedge clock, posedge reset)
	    if ( reset ) state <= IDLE;
        else     	 state <= next_state;

    always @(*)
    case (state)
        IDLE:
            if (watering & (splinker_switch & !dripper_switch)) next_state <= SPLINKER;
            else begin
                if (watering & (!splinker_switch & dripper_switch)) next_state <= DRIPPER;
                else next_state <= IDLE;
            end
        SPLINKER:
            if (!watering) next_state <= IDLE;
            else next_state <= SPLINKER;
        DRIPPER:
            if (!watering) next_state <= IDLE;
            else next_state <= DRIPPER;
        default:
            next_state <= IDLE;
    endcase

    assign splinker = (state == SPLINKER);
    assign dripper = (state == DRIPPER);

endmodule