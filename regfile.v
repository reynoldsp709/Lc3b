/* Module: regfile();
*
*  Parameter:
*      In:      in - 16-bit input value to be written into the destination register
*               clk_50 - Clock
*               sr1 - Address of first source register to read
*               sr2 - Address of second source register to read
*               dr - Address of the destination register
*               ldreg - Write enable for the 'in' value
*      Out:     sr1_out - Value read from first source register
*               sr2_out - Value read from second source register
*
*  Description: The module implements a 16x8 array to output values located
*               at two memory registers and write to memory registers.
*
*  Author: Patrick Reynolds
*/

module regfile (
	in,
	clk_50,
	sr1,
	sr2,
	dr,
	ldreg,
	sr1_out,
	sr2_out
);

input [15:0] in;
input clk_50;
input [2:0] sr1;
input [2:0] sr2;
input [2:0] dr;
input ldreg;
output [15:0] sr1_out;
output [15:0] sr2_out;

integer i;
reg [15:0] reg_memory [7:0];

initial begin
	for (i = 0; i < 7; i = i + 1)
		reg_memory[i] <= 0;
end

assign sr1_out = reg_memory[sr1];
assign sr2_out = reg_memory[sr2];

always @(posedge clk_50) begin
	if (ldreg == 1) begin
		reg_memory[dr] <= in;
	end
end

endmodule

module regfile_test();

reg [15:0] in_test;
reg internal_clock;
reg [2:0] sr1_test;
reg [2:0] sr2_test;
reg [2:0] dr_test;
reg ldreg_test;
wire [15:0] sr1_out_test;
wire [15:0] sr2_out_test;

regfile dut(
	.in			(in_test),
	.clk_50		(internal_clock),
	.sr1			(sr1_test),
	.sr2			(sr2_test),
	.dr			(dr_test),
	.ldreg		(ldreg_test),
	.sr1_out		(sr1_out_test),
	.sr2_out		(sr2_out_test)
);

initial begin
	in_test <= 0;
	internal_clock <= 0;
	sr1_test <= 3'b000;
	sr2_test <= 3'b001;
	dr_test <= 0;
	ldreg_test <= 0;
	
	// Load the decimal number 17 into default destination register '0'
	#5
	ldreg_test <= 1;
	in_test <= 5'd17;
	
	#5
	sr1_test <= 3'b001;
	sr2_test <= 3'b000;
	
	#5
	ldreg_test <= 0;
	in_test <= 5'd20;
	
	#10
	ldreg_test <= 1;
end

always begin
	#5 internal_clock <= !internal_clock;
end

endmodule