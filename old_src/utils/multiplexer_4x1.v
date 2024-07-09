//! A simple 4x1 Multiplexer
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
module multiplexer_4x1(
    output out,

    input bit_3,
    input bit_2,
    input bit_1,
    input bit_0,

    input [3:0] ring_counter
);

    wire [3:0] bus;

    and (bus[3], bit_3, ring_counter[3]);
    and (bus[2], bit_2, ring_counter[2]);
    and (bus[1], bit_1, ring_counter[1]);
    and (bus[0], bit_0, ring_counter[0]);

    or  (out, bus[3], bus[2], bus[1], bus[0]);

endmodule