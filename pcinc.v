/* Module: pcinc();
*
*  Parameter:
*      In:      in - 16-bit input value
*      Out:     out - 16-bit incremented output value
*
*  Description: The module outputs the input value incremented by 2.
*
*  Author: Patrick Reynolds
*/

module pcinc (
	in,
	out
);

input wire [15:0] in;
output [15:0] out;

assign out = in + 16'd2;

endmodule