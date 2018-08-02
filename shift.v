/* Module: shift();
*
*  Parameter:
*      In:      a - 1-bit arithmetic value, determines sign preservation
*               d - 1-bit directional value, determines direction of shift
*               amt - 4-bit integer value, determines number of bits shifted
*               in - 16-bit input value to be shifted
*      Out:     out - 16-bit shifted output value
*
*  Description: The module shifts the input binary value by a given number of bits
*               left or right, depending on the direction value. The arithmetic
*               value determines whether the sign will be preserved or not.
*
* Author: Patrick Reynolds
*/

module shift (
	a,
	d,
	amt,
	in,
	out
);

input a;
input d;
input [3:0] amt;
input [15:0] in;
output reg [15:0] out;

always @(*) begin
	if (d == 0)
		out <= in << amt;
	else
		if (a == 0)
			out <= in >> amt;
		else
			out <= $signed(in) >>> amt;
end

endmodule

module shift_test();

reg internal_clock;
reg a_test;
reg d_test;
reg [3:0] amt_test;
reg [15:0] in_test;
wire [15:0] out_test;

shift dut(
	.a		(a_test),
	.d		(d_test),
	.amt	(amt_test),
	.in	(in_test),
	.out	(out_test)
);

initial begin
	internal_clock <= 0;
	a_test <= 0;
	d_test <= 0;
	amt_test <= 0;
	in_test <= 6'b101011;
	
	#5
	amt_test <= 2'b10;
	
	#5
	d_test <= 1;
	
	#5
	a_test <= 1;
end

always begin
	#5 internal_clock <= !internal_clock;
end

endmodule