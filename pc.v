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
	clock_50,
	in,
	load,
	out
);

input [15:0] in;
input clock_50, load;
output reg [15:0] out;

always @(posedge clock_50) begin
	if (load == 1) begin
		out <= in;
	end
end

initial begin
	out = 0;
end

endmodule