module sext (
in,
out,
clk_50
);

parameter WIDTH = 7;

input clk_50;
input [WIDTH-1:0] in;
output [15:0] out;

wire [WIDTH-1:0] in;

assign out = {{(16-WIDTH){in[WIDTH-1]}}, in[WIDTH-1:0]};

endmodule

module sext_test #(parameter WIDTH = 7);

reg internal_clock;
reg [WIDTH-1:0]in_test;
wire [15:0] out_test;
sext dut(
.in				(in_test),
.out				(out_test),
.clk_50			(internal_clock)
);

initial begin
	in_test = -10;
	internal_clock = 0;
end

always begin
	#5 internal_clock = !internal_clock;
end

always @(posedge internal_clock) begin
	in_test = in_test + 1;
end

endmodule
