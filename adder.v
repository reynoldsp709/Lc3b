/* Module: adder();
*
*  Parameter:
*      In:      a - First 16-bit input value
*               b - Second 16-bit input value
*      Out:     out - 16-bit added result output
*
*  Description: The module outputs the sum of inputs a and b.
*
*  Author: Patrick Reynolds
*/

module adder (
	a,
	b,
	out
);

input [15:0] a, b;
output [15:0] out;

assign out = a + b;

endmodule