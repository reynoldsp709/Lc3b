/* Module: mux2();
*
*  Parameter:
*      In:      in - 16-bit input value to be selected from
*               select - 3-bit select line that sends the corresponding bit value to the output
*      Out:     out - 1-bit output value bit selected from 'in'
*
*  Description: The module outputs the variable width input number padded to 16-bits with its sign bit value.
*
*  Author: Patrick Reynolds
*/

module mux2 (
	in0,
	in1,
	select,
	out
);

input [15:0] in0, in1;
input select;
output [15:0] out;

assign out = select ? in0 : in1;

endmodule