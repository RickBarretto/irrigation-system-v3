//! Decodes binary code to output display
//!
//! Moreover, this also implements the letters E, r and o,
//! what makes it possible to create the word Erro, on display.
//!
//! Being their codes:
//!
//! Char [3:0]data
//! ---- ---------
//!  E     1100
//!  r     1110
//!  o     1111
module display_decoder(
    output a, output b, output c,
    output d, output e, output f,
    output g,

    input [3:0] data
);

    //!     a
    //!   -----
    //! f |   | b
    //!   --g--
    //! e |   | c
    //!   -----
    //!     d

    //!     Input    Output
    //! --- ----- -------------
    //! Rep  Bin  A B C D E F G
    //! --- ----- - - - - - - -
    //!  0  0000  0 0 0 0 0 0 1
    //!  1  0001  1 0 0 1 1 1 1
    //!  2  0010  0 0 1 0 0 1 0
    //!  3  0011  0 0 0 0 1 1 0
    //!  4  0100  1 0 0 1 1 0 0
    //!  5  0101  0 1 0 0 1 0 0
    //!  6  0110  0 1 0 0 0 0 0
    //!  7  0111  0 0 0 1 1 1 1
    //!  8  1000  0 0 0 0 0 0 0
    //!  9  1001  0 0 0 0 1 0 0
    //!  .  1010  * * * * * * *
    //!  E  1011  0 1 1 0 0 0 0
    //!  r  1100  1 1 1 1 0 1 0
    //!  o  1101  1 1 0 0 0 1 0
    //!  A  1110  0 0 0 1 0 0 0
    //!  F  1111  0 1 1 1 0 0 0

    // Negative Wires
    wire [3:0] negative;

    not (negative[3], data[3]);
    not (negative[2], data[2]);
    not (negative[1], data[1]);
    not (negative[0], data[0]);

    // Segments

    // Segment A = A'B'C'D + BC'D' + ABC'
    and (a_term_1, negative[3], negative[2], negative[1], data[0]);
    and (a_term_2, data[2], negative[1], negative[0]);
    and (a_term_3, data[3], data[2], negative[1]);
    or  (a, a_term_1, a_term_2, a_term_3);

    // Segment B = A'BCD' + BC'D + ACD + ABC'
    and (b_term_1, negative[3], data[2], data[1], negative[0]);
    and (b_term_2, data[2], negative[1], data[0]);
    and (b_term_3, data[3], data[1], data[0]);
    and (b_term_4, data[3], data[2], negative[1]);
    or  (b, b_term_1, b_term_2, b_term_3, b_term_4);

    // Segment C = ABC'D' + ACD + B'CD'
    and (c_term_1, data[3], data[2], negative[1], negative[0]);
    and (c_term_2, data[3], data[1], data[0]);
    and (c_term_3, negative[2], data[1], negative[0]);
    or  (c, c_term_1, c_term_2, c_term_3);

    // Segment D = A'B'C'D + BC'D' + BCD + ACD'
    and (d_term_1, negative[3], negative[2], negative[1], data[0]);
    and (d_term_2, data[2], negative[1], negative[0]);
    and (d_term_3, data[2], data[1], data[0]);
    and (d_term_4, data[3], data[1], negative[0]);
    or  (d, d_term_1, d_term_2, d_term_3, d_term_4);

    // Segment E = A'BC'D' + B'C'D + A'CD
    and (e_term_1, negative[3], data[2], negative[1], negative[1]);
    and (e_term_2, negative[2], negative[1], data[0]);
    and (e_term_3, negative[3], data[1], data[0]);
    or  (e, e_term_1, e_term_2, e_term_3);

    // Segment F = A'CD + B'CD' + ABC' + A'B'D
    and (f_term_1, negative[3], data[1], data[0]);
    and (f_term_2, negative[2], data[1], negative[0]);
    and (f_term_3, data[3], data[2], negative[1]);
    and (f_term_4, negative[3], negative[2], data[0]);
    or  (f, f_term_1, f_term_2, f_term_3, f_term_4);

    // Segment G = A'BCD + A'B'C'
    and (g_term_1, negative[3], data[2], data[1], data[0]);
    nor (g_term_2, data[3], data[2], data[1]);
    or  (g, g_term_1, g_term_2);


endmodule
