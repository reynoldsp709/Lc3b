/*	Module: sext(WIDTH);
*
*	Parameter:
*		In: 			in - 8-bit input value to be extended
*		Out: 			out - 16-bit zero-extended output value
*
*	Description: 	The module outputs the variable width input number padded to 16-bits with its sign bit value.
*
*	Author: Patrick Reynolds
*/

module sext (
in,
out
);

parameter WIDTH = 7;

input [WIDTH-1:0] in;
output [15:0] out;

wire [WIDTH-1:0] in;

assign out = {{(16-WIDTH){in[WIDTH-1]}}, in[WIDTH-1:0]};

endmodule

module sext_test #(parameter WIDTH = 7);

reg internal_clock;
reg [WIDTH-1:0]in_test;
wire [15:0] out_test;

sext dut(
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
