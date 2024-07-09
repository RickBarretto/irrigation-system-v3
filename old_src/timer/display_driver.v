module display_driver (
    output [3:0] out,

    input [3:0] ring_counter,

    input [3:0] data_3,
    input [3:0] data_2,
    input [3:0] data_1,
    input [3:0] data_0
);

    multiplexer_4x1 (out[3], data_3[3], data_2[3], data_1[3], data_0[3], ring_counter);
    multiplexer_4x1 (out[2], data_3[2], data_2[2], data_1[2], data_0[2], ring_counter);
    multiplexer_4x1 (out[1], data_3[1], data_2[1], data_1[1], data_0[1], ring_counter);
    multiplexer_4x1 (out[0], data_3[0], data_2[0], data_1[0], data_0[0], ring_counter);

endmodule