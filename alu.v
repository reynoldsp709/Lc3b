/*	Module: sext();
*
*	Parameter:
*		In: 			aluk - 2-bit input control value that determines ALU operation
*						a - First 16-bit input value operand
*						b - First 16-bit input value operand
*		Out: 			result - 16-bit ALU result value
*
*	Description:	The module outputs the variable width input number padded to 16-bits with its sign bit value.
*
*	Author: Patrick Reynolds
*/

module alu (
	aluk,
	a,
	b,
	result
);

input [1:0] aluk;
input [15:0] a;
input [15:0] b;
output reg [15:0] result;

always @(*) begin
	case(aluk)
	2'b00:
		result <= a + b;
	2'b01:
		result <= a & b;
	2'b10:
		result <= a ^ b;
	2'b11:
		result <= a;
	default: result <= a + b;
	endcase
end

endmodule

module alu_test();

reg internal_clock;
reg [1:0] aluk_test;
reg [15:0] a_test;
reg [15:0] b_test;
wire [15:0] result_test;

alu dut(
	.aluk		(aluk_test),
	.a			(a_test),
	.b			(b_test),
	.result	(result_test)
);

initial begin
	internal_clock <= 0;
	aluk_test <= 0;
	a_test <= 4'b1100;
	b_test <= 4'b1010;
end

always begin
	#5 internal_clock <= !internal_clock;
end

always @(posedge internal_clock) begin
	aluk_test <= aluk_test + 1;
end

endmodule