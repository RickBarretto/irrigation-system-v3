//! A simple 3x1 Multiplexer
//!
//! This MUX was created to be used with the ring counter,
//! where only one of the selectors are active per time.
//!
//! This may be used by other modules to select which data output,
//! according to FLOYD (2007).
//!
//! Reference
//! ---------
//! FLOYD, T. Funções da Lógica Combinacional.
//! In: JÚNIOR, A. P. (Ed.). Sistemas Digitais: Fundamentos e Aplicações.
//! Tradução: José Lucimar Do Nascimento. Porto Alegre: Bookman, 2007. p. 312–364.
//!
module multiplexer_3x1(
    output out,

    input bit_2,
    input bit_1,
    input bit_0,

    input [2:0] ring_counter
);

    wire bus_2, bus_1, bus_0;

    and (bus_2, bit_2, ring_counter[2]);
    and (bus_1, bit_1, ring_counter[1]);
    and (bus_0, bit_0, ring_counter[0]);

    or  (out, bus_2, bus_1, bus_0);

endmodule