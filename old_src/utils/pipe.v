//! Pipe just assigns a signal to another one.
//!
//! There is a property that says: A * A = A
module pipe(output out, input a);
    and (out, a, a);
endmodule