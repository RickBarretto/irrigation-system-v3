//! A simple 2x1 Multiplexer
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
module multiplexer_2x1(
    output out,

    input a,
    input b,
    input selector
);

    wire a_bus, b_bus;
    not (not_selector, selector);

    and (a_bus, a, selector);
    and (b_bus, b, not_selector);
    or (out, a_bus, b_bus);

endmodule