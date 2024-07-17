module fertilising_controller (
    output fertilising,
    output cleaning,

    input critical_level,
    input empty_tank,
    input splinker,
    input fertilise_push,
);

    assign set = fertilise_push & splinker & !critical_level;
    flipflop_d(fertilising, clock, set, critical_level, 0);

    assign cleaning = !fertilising & critical_level & !empty_tank;

endmodule