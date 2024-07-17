module fertilising_controller (
    output fertilising,
    output cleaning,
    output alarm,

    input critical_level,
    input empty_tank,
    input splinker,
    input fertilise_push
);

    assign condition_of_fertilisation = splinker & !critical_level;
    assign set = fertilise_push & !condition_of_fertilisation;

    flipflop_d(fertilising, clock, set, critical_level, 0);

    assign alarm = !condition_of_fertilisation;
    assign cleaning = !fertilising & critical_level & !empty_tank;

endmodule