module set_display_init (
	output [3:0] minutes_d_setter,
    output [3:0] minutes_u_setter,

	output [3:0] minutes_d_resetter,
	output [3:0] minutes_u_resetter,
	output [3:0] seconds_d_resetter,

    input recount,
    input splinker_mode_on
);

    // Splinker: 0001 0101 0000
    // Dripper : 0011 0000 0000

    not (dripper_mode_on, splinker_mode_on);

    // Sets Seconds' D
    pipe (seconds_d_resetter[3], recount);
    pipe (seconds_d_resetter[2], recount);
    pipe (seconds_d_resetter[1], recount);
    pipe (seconds_d_resetter[0], recount);

    // Sets Minutes 'U
    and (minutes_u_resetter[3], recount);

    and (minutes_u_setter[2], splinker_mode_on, recount);
    and (minutes_u_resetter[2], dripper_mode_on, recount);

    and (minutes_u_resetter[1], recount);

    and (minutes_u_setter[0], splinker_mode_on, recount);
    and (minutes_u_resetter[0], dripper_mode_on, recount);

    // Sets Minutes' D
    and (minutes_d_resetter[3], recount);
    and (minutes_d_resetter[2], recount);

    and (minutes_d_setter[1], dripper_mode_on, recount);
    and (minutes_d_resetter[1], splinker_mode_on, recount);

    and (minutes_d_setter[0], recount);


endmodule