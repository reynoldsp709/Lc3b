/* Module: lshf1();
*
*  Parameter:
*      In:      in - 16-bit input value
*               enable - 1-bit shift-enable control signal
*      Out:     out - 16-bit single-left-shifted output value
*
*  Description: The module outputs the input value left-shifted by one.
*
*  Author: Patrick Reynolds
*/

module lshf1 (
	in,
	enable,
	out
);

input [15:0] in;
input enable;
output [15:0] out;

assign out <= enable ? in : in << 1;

endmodule