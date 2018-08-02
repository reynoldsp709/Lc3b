/* Module: gateshf();
*
*  Parameter:
*      In:      enable - Gate enable value
*               in - 16-bit input value
*      Out:     out - 16-bit output value
*
*  Description: The module sends either the input value or high impedance to the output,
*               depending on the enable value.
*
*  Author: Patrick Reynolds
*/

module gateshf (
	enable,
	in,
	out
);

input enable;
input [15:0] in;
output reg [15:0] out;

always @(*) begin
	if (enable == 0)
		out <= 16'bzzzzzzzzzzzzzzzz;
	else
		out <= in;
end

endmodule

module gateshf_test();

reg internal_clock;
reg enable_test;
reg [15:0] in_test;
wire [15:0] out_test;

gateshf dut(
	.enable	(enable_test),
	.in		(in_test),
	.out		(out_test)
);

initial begin
	internal_clock <= 0;
	enable_test <= 0;
	in_test <= 6'b110011;
end

always begin
	#5 internal_clock <= !internal_clock;
end

always @(posedge internal_clock) begin
	enable_test <= enable_test + 1;
end

endmodule