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