module mux4 (
	in0,
	in1,
	in2,
	in3,
	select,
	out
);

input [15:0] in0, in1, in2, in3;
input [1:0] select;
output [15:0] out;

always @(*) begin
	case(select)
		2'd0: 
			out <= in0;
		2'd1:
			out <= in1;
		2'd2:
			out <= in2;
		2'd3:
			out <= in3;
	endcase
end
endmodule