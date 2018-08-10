/* Module: mux2();
*
*  Parameter:
*      In:      in0 - First 16-bit input value
*               in1 - Second 16-bit input value
*               select - 1-bit select line that sends the corresponding input value to the output
*      Out:     out - 1-bit output value bit selected from 'in'
*
*  Description: The module outputs one of two 16-bit input values based on the select value.
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