module error_or_info (
    output [3:0] out,

    input has_error,

    input [3:0] info,
    input [3:0] error
);

    multiplexer_2x1 (out[3], error[3], info[3], has_error);
    multiplexer_2x1 (out[2], error[2], info[2], has_error);
    multiplexer_2x1 (out[1], error[1], info[1], has_error);
    multiplexer_2x1 (out[0], error[0], info[0], has_error);

endmodule