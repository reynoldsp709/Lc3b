/* Module: ir();
*
*  Parameter:
*      In:      in - 16-bit input value
*               load - 1-bit load-enable control signal
*      Out:     out - 16-bit incremented output value
*
*  Description: The module outputs the input value incremented by 2.
*
*  Author: Patrick Reynolds
*/

module ir (
	in,
	load,
	out
);

input [15:0] in;
input load;
output [15:0] out;

assign out = load ? 1'bz : in;

endmodule
