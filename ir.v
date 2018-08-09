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
