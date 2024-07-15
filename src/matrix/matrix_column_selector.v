module matrix_column_selector (
    output reg [6:0] selected_column,
    output [4:0] ring_counter,

    input [6:0] column_4,
    input [6:0] column_3,
    input [6:0] column_2,
    input [6:0] column_1,
    input [6:0] column_0,

    input clock,
    input reset
);

  parameter count4 = 5'b00001;
  parameter count3 = 5'b00010;
  parameter count2 = 5'b00100;
  parameter count1 = 5'b01000;
  parameter count0 = 5'b10000;

  column_selector(ring_counter, clock, reset);

  // always @(posedge clock, posedge reset) begin
  //  if (reset) ring_counter <= count4;
  //  else ring_counter <= {ring_counter[0], ring_counter[4:1]};
  // end

	 always @(*)
    case (ring_counter)
        count4: selected_column <= column_4;
        count3: selected_column <= column_3;
        count2: selected_column <= column_2;
        count1: selected_column <= column_1;
        count0: selected_column <= column_0;
        default: selected_column <= 7'b1111111;
    endcase

endmodule