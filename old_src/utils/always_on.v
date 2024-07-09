//! Always on returns a positive signal, independent of the given entry.
//!
//! There is a property that says: A + A' = 0
//! Since, 0 or 1 is always 1.
module always_on(output on, input a);
	not (a_not, a);
	or  (on, a, a_not);
endmodule