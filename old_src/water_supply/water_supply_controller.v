//! Controls the water supply's valule
//!
//! This must be closed always when:
//! 1. There are conflicting values coming from the sensors
//! 2. The water tank is full, basically when the water level is high
//!
//! The returning value is 4'b1111 when closed and 4'b1110 when opened.
module water_supply_controller (
    output [3:0] valvule,

    input water_sensors_conflicting,
    input high_water_level
);

    always_on (valvule[3], high_water_level);
    always_on (valvule[2], high_water_level);
    always_on (valvule[1], high_water_level);
    or (valvule[0], water_sensors_conflicting, high_water_level);

endmodule