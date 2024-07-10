module matrix_column_selector (
    output [6:0] selected_column,
    output [4:0] ring_counter,

    input [6:0] column_4,
    input [6:0] column_3,
    input [6:0] column_2,
    input [6:0] column_1,
    input [6:0] column_0,

    input clock,
    input reset
);

  reg [4:0] state, nextstate;

  parameter count4 = 5'b00001;
  parameter count3 = 5'b00010;
  parameter count2 = 5'b00100;
  parameter count1 = 5'b01000;
  parameter count0 = 5'b10000;

  always @(posedge clock, posedge reset)
    if ( reset ) state <= count4;
    else     	 state <= nextstate;

  always @(*)
    case (state)
        count4: if (level) nextstate <= count3; else nextstate <= count4;
        count3: if (level) nextstate <= count2; else nextstate <= count3;
        count2: if (level) nextstate <= count1; else nextstate <= count2;
        count1: if (level) nextstate <= count0; else nextstate <= count1;
        count0: if (level) nextstate <= count4; else nextstate <= count0;
        default: nextstate <= count4;
    endcase

  always @(*)
    case (state)
        count4: selected_column <= column_4;
        count3: selected_column <= column_3;
        count2: selected_column <= column_2;
        count1: selected_column <= column_1;
        count0: selected_column <= column_0;
        default: selected_column <= 7'b1111111;
    endcase

endmodule