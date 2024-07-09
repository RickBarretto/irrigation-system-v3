//! Display Selector is a 4 bit Ring Counter
module display_selector (output [3:0] displays, input clock, input pulse);

    not (released, pulse);

    //                 Q      clock     set      reset        D
    //            ----------- ------ --------- --------- ------------
    flipflop_d D3(displays[3], clock, released,     0   , displays[0]);
    flipflop_d D2(displays[2], clock,     0   , released, displays[3]);
    flipflop_d D1(displays[1], clock,     0   , released, displays[2]);
    flipflop_d D0(displays[0], clock,     0   , released, displays[1]);

endmodule
