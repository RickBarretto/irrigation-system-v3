module irrigation_fsm (
    output splinker,
    output dripper,

    input clock,
    input reset,

    input full_tank,
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
            if (full_tank & (splinker_switch & !dripper_switch)) next_state <= SPLINKER;
            else begin
                if (full_tank & (!splinker_switch & dripper_switch)) next_state <= DRIPPER;
                else next_state <= IDLE;
            end
        SPLINKER:
            next_state <= SPLINKER;
        DRIPPER:
            next_state <= DRIPPER;
        default:
            next_state <= IDLE;
    endcase

    assign splinker = (state == SPLINKER);
    assign dripper = (state == DRIPPER);

endmodule