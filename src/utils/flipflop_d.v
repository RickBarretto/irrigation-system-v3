module flipflop_d (
    output reg q,

    input clock,
    input set,
    input reset,
    input d
);

    always @(posedge clock or posedge set or posedge reset) begin
        if (reset)      q <= 1'b0;
        else if (set)   q <= 1'b1;
        else            q <= d;
    end

endmodule


module flipflop_d1 (
    output reg q = 1,

    input clock,
    input set,
    input reset,
    input d
);

    always @(posedge clock or posedge set or posedge reset) begin
        if (reset)      q <= 1'b0;
        else if (set)   q <= 1'b1;
        else            q <= d;
    end

endmodule