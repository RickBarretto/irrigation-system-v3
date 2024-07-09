//! LED matrix's decoder
//!
//! This decoder takes an encoded data and generates the needed images
//! to be displayed on the LED matrix of the CPLD Kit, when showing the irrigation system.
//!
//! To reduce resources usage, the images have been choosen to be simetric on the Y-axis,
//! what means that only three columns are needed for a 5-column display.
module irrigation_mode_decoder (
    output [6:0] col_2, //! Columns: 0 & 4
    output [6:0] col_1, //! Columns: 1 & 3
    output [6:0] col_0, //! Columns: 2

    input splinker,
    input irrigation
);

    //! Images
    //! ------
    //!
    //!  Splinker    Dripper   Irrigation Off
    //! ----------  ---------  --------------
    //!  2 1 0 1 2  2 1 0 1 2    2 1 0 1 2
    //!  - - - - -  - - - - -    - - - - -
    //!    * * *                     *
    //!  *   *   *      *            *
    //!  *   *   *    * * *          *
    //!      *        * * *          *
    //!      *      * * * * *        *
    //!    * * *    * * * * *
    //!  * * * * *    * * *          *

    // Helper wires

    wire on, off;
    wire dripper;
    wire irrigation_off;

    always_on (on, splinker);
    not (off, on);
    not (irrigation_off, irrigation);
    not (dripper, splinker);

    // Common combinations

    or (just_dripper, irrigation_off, dripper);
    or (just_splinker, irrigation_off, splinker);

    // Colunn 2
    pipe (col_2[6], on);            // Y = 1
    pipe (col_2[5], just_dripper);  // Y = I' + S'
    pipe (col_2[4], just_dripper);  // Y = I' + S'
    pipe (col_2[3], on);            // Y = 1
    pipe (col_2[2], just_splinker); // Y = I' + S
    pipe (col_2[1], just_splinker); // Y = I' + S
    pipe (col_2[0], just_dripper);  // Y = I' + S'

    // Column 1
    pipe (col_1[6], just_dripper);  // Y = I' + D
    pipe (col_1[5], on);            // Y = 1
    pipe (col_1[4], just_splinker); // Y = I' + S
    pipe (col_1[3], just_splinker); // Y = I' + S
    pipe (col_1[2], just_splinker); // Y = I' + S
    pipe (col_1[1], irrigation_off);    // Y = I'
    pipe (col_1[0], irrigation_off);    // Y = I'

    // Column 0
    and  (col_0[6], irrigation, dripper);   // Y = S'I'
    pipe (col_0[5], off);                   // Y = 1
    pipe (col_0[4], off);                   // Y = 1
    pipe (col_0[3], off);                   // Y = 1
    pipe (col_0[2], off);                   // Y = 1
    pipe (col_0[1], irrigation_off);        // Y = I'
    pipe (col_0[0], off);                   // Y = 1


endmodule