/* Module: pc();
*
*  Parameter:
*      In:      in - 16-bit input value
*               load - 1-bit load-enable control signal
*      Out:     out - 16-bit incremented output value
*
*  Description: The module outputs the input value or high impedance depending on the load value.
*
*  Author: Patrick Reynolds
*/

module pc (
	in,
	load,
	out
);

input [15:0] in;
input load;
output [15:0] out;

assign out = load ? in : 1'bz;

endmodule