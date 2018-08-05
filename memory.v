// Make a memory module

module memory (
    clk_50,
    ldMar,
    ldMdr,
    r,
    rw,
    bus,
    datasize, // 1 means 8 bits, 0 means 16
    gateMdr
);

input clk_50;
input ldMar;
input ldMdr;
input gateMdr;
input datasize;
input rw;
output reg r;
inout bus;

reg [3:0] counter;
reg [15:0] mar, mdr;
reg loading;
reg saving;

reg [7:0] memory [15:0] = {
    // where our memory goes
    // ADD r0, r0, r1
    0x1030
};

`include "sign_extend.v"

always @(posedge clk_50) begin
    // the memory is currently trying to load something
    if(loading == 1) begin
        counter <= counter - 1;
        if (counter <= 0) begin
				if (datasize == 1) begin
					if (sb == 1) begin
						mdr <= {memory[mar],memory[mar]};
					end
					else if (mar[0] == 1) begin
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
    else if(saving == 1 && rw == 1) begin
        counter <= counter - 1;
        if(counter <= 0) begin
            if (datasize == 1) begin
                // 8 bit case
					 memory[mar] <= mdr[7:0];
            end else
                // 16 bit case
                memory[mar] <= mdr[15:8];
                memory[mar + 1] <= mdr[7:0];
                r <= 1;
            end
        end else begin
            r <= 0;
        end
    end
    // normal behavior block
    else begin
        r <= 0;
        if(ldMar == 1) begin
            loading <= 1;
            mar <= bus;
            counter <= 5;
		  end
        else if(ldMdr == 1) begin
            saving <= 1;
            mdr <= bus;
            counter <= 10;
        end
    end
end

endmodule