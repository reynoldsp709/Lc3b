module mux16 (
in,
out,
clk_50,
select
);

input clk_50;
input [15:0] in;
input [3:0] select;
output out;

assign out = in[select];

endmodule

module mux16_test();

reg internal_clock;
reg [15:0]in_test;
reg [3:0] select_test;
wire out_test;
mux16 dut(
.in				(in_test),
.out				(out_test),
.select			(select_test),
.clk_50			(internal_clock)
);

initial begin
	in_test = 0;
	internal_clock = 0;
	select_test = 0;
end

always begin
	#5 internal_clock = !internal_clock;
end

always @(posedge internal_clock) begin
	if (select_test > 15) begin
		select_test = 0;
		in_test = in_test + 1;
	end
	select_test = select_test + 1;
end

endmodule