/*	Module: zext();
*
*	Parameter:
*		In: 			in - 8-bit input value to be extended
*		Out: 			out - 16-bit zero-extended output value
*
*	Description:	The module outputs the 8-bit input number padded with zeroes to 16-bits.
*
*	Author: Patrick Reynolds
*/

module zext (
in,
out
);

input [7:0] in;
output [15:0] out;

wire [7:0] in;

assign out = in;

endmodule

module zext_test ();

reg internal_clock;
reg [7:0] in_test;
wire [15:0] out_test;
zext dut(
.in				(in_test),
.out				(out_test)
);

initial begin
	in_test <= -10;
	internal_clock <= 0;
end

always begin
	#5 internal_clock <= !internal_clock;
end

always @(posedge internal_clock) begin
	in_test <= in_test + 1;
end

endmodule
