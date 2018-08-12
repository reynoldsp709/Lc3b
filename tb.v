module tb();

reg clock;

LC_3b dut(
	.CLOCK_50(clock)
);

initial begin
	clock = 0;
end

always begin
	#5 clock <= !clock;
end

endmodule