module flipflop_t (
    output reg q,

    input clock,
    input reset,
    input t
);

    always @(posedge clock) begin
        if (!reset) q <= 0;
        else if (t) q <= ~q;
        else        q <= q;
    end

endmodule