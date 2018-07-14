module zext (
in,
out,
clk_50
);

input clk_50;
input [7:0] in;
output [15:0] out;

wire [7:0] in;

assign out = in;

endmodule

module zext_test ();

reg internal_clock;
reg [7:0] in_test;
wire [15:0] out_test;
zext dut(
.in				(in_test),
.out				(out_test),
.clk_50			(internal_clock)
);

initial begin
	in_test = 0;
	internal_clock = 0;
end

always begin
	#5 internal_clock = !internal_clock;
end

always @(posedge internal_clock) begin
	in_test = in_test + 1;
end

endmodule
