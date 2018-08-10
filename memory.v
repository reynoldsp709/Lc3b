/* Module: memory();
*
*  Parameter:
*      In:      clk_50 - Clock
*               bus - 16-bit input from bus
*               ldMar - 1-bit load-enable control signal (MAR)
*               ldMdr - 1-bit load-enable control signal (MDR)
*               datasize - 1-bit control signal for load/store byte instructions
*               rw - 1-bit read/write control signal
*      Out:     r - 1-bit memory-ready output value
*
*  Description: The module implements a 8x16 memory array to load and store instructions
*               and values for use in the LC-3b microarchitecture.
*
*  Author: Patrick Reynolds
*/

module memory (
    clk_50,
	 bus,
    ldMar,
    ldMdr,
    datasize, // 1 means 8 bits, 0 means 16
    rw,
    r
);

input clk_50;
input ldMar;
input ldMdr;
input datasize;
input rw;
output reg r;
//inout bus;
input bus;

reg [3:0] counter;
reg [15:0] mar, mdr;
reg loading;
reg saving;

reg [7:0] memory [15:0];

`include "sign_extend.v"

always @(posedge clk_50) begin
    // the memory is currently trying to load something
    if (loading == 1) begin
        counter <= counter - 1;
        if (counter <= 0) begin
				if (datasize == 1) begin
					if (mar[0] == 1) begin
						mdr <= sign_extend(memory[mar]);
						r <= 1;
					end
					else begin
						mdr <= sign_extend(memory[mar + 1]);
						r <= 1;
					end
				end
				else begin
					// return the desired value
					mdr <= (memory[mar] << 8) | memory[mar + 1];
					r <= 1;
				end
		  end
        else begin
            r <= 0;
        end
	 end
    else if (saving == 1 && rw == 1) begin
        counter <= counter - 1;
        if (counter <= 0) begin
            if (datasize == 1) begin
                // 8 bit case
					 memory[mar] <= mdr[7:0];
					 r <= 1;
            end
				else begin
                // 16 bit case
                memory[mar] <= mdr[15:8];
                memory[mar + 1] <= mdr[7:0];
                r <= 1;
            end
        end
		  else begin
            r <= 0;
        end
    end
    // normal behavior block
    else begin
        r <= 0;
        if (ldMar == 1) begin
            loading <= 1;
            mar <= bus;
            counter <= 5;
		  end
        else if (ldMdr == 1) begin
            saving <= 1;
            mdr <= bus;
            counter <= 10;
        end
    end
end

endmodule

module memory_test ();

reg internal_clock;
reg ldMar_test;
reg ldMdr_test;
reg gateMdr_test;
reg datasize_test;
reg rw_test;
reg wr;
wire r_test;
reg bus_test;

//assign bus = wr ? din : 1'bz;

memory dut(
    .clk_50		(internal_clock),
    .ldMar		(ldMar_test),
    .ldMdr		(ldMdr_test),
    .r			(r_test),
    .rw			(rw_test),
    .bus			(bus_test),
    .datasize	(datasize_test)
);

initial begin
	internal_clock <= 0;
	ldMar_test <= 0;
	ldMdr_test <= 0;
	datasize_test <= 0;
	rw_test <= 0;
	wr <= 0;
	bus_test <= 16'd7;
	
	// Save the integer value '7' to memory location 0x0000
	#5
	rw_test <= 1;
	ldMdr_test <= 1;
	
	
end

always begin
	#5 internal_clock <= !internal_clock;
end

endmodule