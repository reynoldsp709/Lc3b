/* Module: control();
*
*  Parameter:
*      In:      clk_50 - Clock
*               r - 1-bit memory-ready input value
*               ir - 16-bit instruction register
*               bus - 16-bit bus input value
*      Out:     pcmux - 2-bit mux-select control signal
*               addr1mux - 1-bit mux-select control signal
*               addr2mux - 2-bit mux-select control signal
*               sr2mux - 1-bit mux-select control signal
*               marmux - 1-bit mux-select control signal
*               aluk - 2-bit ALU function control signal
*               sr1 - Address of first source register to read
*               sr2 - Address of second source register to read
*               dr - Address of the destination register
*               ldmar - 1-bit load-enable control signal
*               ldmdr - 1-bit load-enable control signal
*               ldpc - 1-bit load-enable control signal
*               ldir - 1-bit load-enable control signal
*               ldcc - 1-bit load-enable control signal
*               ldreg - 1-bit load-enable control signal
*               gatepc - 1-bit gate-enable control signal
*               gatemdr - 1-bit gate-enable control signal
*               gatealu - 1-bit gate-enable control signal
*               gateshf - 1-bit gate-enable control signal
*               gatemarmux - 1-bit gate-enable control signal
*               rw - 1-bit read/write control signal
*               datasize - 1-bit control signal for load/store byte instructions
*               lshf - 1-bit shift-enable control signal
*
*  Description: The module acts as a control unit for the LC-3b architecture. 
*               Sets gates and select lines along the datapath, and updates the state
*               value of the machine.
*
*  Author: Patrick Reynolds
*/

module control (
	clk_50,
	r,
	ir,
	bus,
	pcmux,
	addr1mux,
	addr2mux,
	sr2mux,
	marmux,
	aluk,
	sr1,
	sr2,
	n,
	z,
	p,
	ldmar,
	ldmdr,
	ldpc,
	ldir,
	ldcc,
	ldreg,
	gatepc,
	gatemdr,
	gatealu,
	gateshf,
	gatemarmux,
	rw,
	datasize,
	dr,
	lshf
);

input clk_50, r;
input [15:0] ir, bus;
output reg addr1mux, sr2mux, marmux, ldmar, ldmdr, ldpc, ldir, ldcc, ldreg, gatepc, gatemdr, gatealu, gateshf, gatemarmux, rw, datasize, lshf;
output reg [1:0] pcmux, addr2mux, aluk;
output reg [2:0] sr1, sr2, dr;
reg n, z, p, ben;
reg [5:0] state;

always @(posedge clk_50) begin
	// Set control codes
	if (ldcc == 1) begin
		if (bus < 0)
			n <= 1;
		else if (bus == 0)
			z <= 1;
		else if (bus > 0)
			p <= 1;
	end
	// Initialize all output values
	pcmux <= 0;
	addr1mux <= 0;
	addr2mux <= 0;
	sr2mux <= 0;
	marmux <= 0;
	aluk <= 0;
	sr1 <= 0;
	sr2 <= 0;
	dr <= 0;
	n <= 0;
	z <= 0;
	p <= 0;
	ldmar <= 0;
	ldmdr <= 0;
	ldpc <= 0;
	ldir <= 0;
	ldcc <= 0;
	ldreg <= 0;
	ben <= 0;
	gatepc <= 0;
	gatemdr <= 0;
	gatealu <= 0;
	gateshf <= 0;
	gatemarmux <= 0;
	rw <= 0;
	datasize <= 0;
	lshf <= 0;
	
	case(state)
	// Load PC into MAR
	6'd18: begin
		gatepc <= 1;
		ldmar <= 1;
		state <= 6'd19;
	end
	// Increment PC
	6'd19: begin
		ldpc <= 1;
		pcmux <= 2'd2;
		state <= 6'd33;
	end
	// Load bus value from memory into MDR, wait for R
	6'd33: begin
		ldmdr <= 1;
		if (r)
			state <= 6'd35;
		else
			state <= 6'd33;
	end
	// Load MDR into IR
	6'd35: begin
		ldir <= 1;
		gatemdr <= 1;
		state <= 6'd32;
	end
	// Set BEN based on CC's and IR
	6'd32: begin
		ben <= ((ir[11] & n) | (ir[10] & z) | (ir[9] & p));
		state <= ir[15:12];
	end
	// Take branch or return to state 18 based on BEN
	6'd0: begin
		if (ben)
			state <= 6'd22;
		else
			state <= 6'd18;
	end
	// Increment PC by IR[10:0]
	6'd22: begin
		ldpc <= 1;
		addr1mux <= 0;
		addr2mux <= 1;
		pcmux <= 1;
		state <= 6'd18;
	end
	// Load value from register SR1 into PC
	6'd12: begin
		ldpc <= 1;
		pcmux <= 0;
		gatealu <= 1;
		aluk <= 2'd3;
		sr1 <= ir[8:6];
		state <= 6'd18;
	end
	// ADD value at register SR1 with IR[4:0] or SR2, store result into DR, set CC's
	6'd1: begin
		sr1 <= ir[8:6];
		sr2 <= ir[2:0];
		if (ir[5])
			sr2mux <= 1;
		else
			sr2mux <= 0;
		aluk <= 0;
		dr <= ir[11:9];
		gatealu <= 1;
		ldreg <= 1;
		ldcc <= 1;
		state <= 6'd18;
	end
	// AND value at register SR1 with IR[4:0] or SR2, store result into DR, set CC's
	6'd5: begin
		sr1 <= ir[8:6];
		sr2 <= ir[2:0];
		if (ir[5])
			sr2mux <= 1;
		else
			sr2mux <= 0;
		aluk <= 1;
		dr <= ir[11:9];
		gatealu <= 1;
		ldreg <= 1;
		ldcc <= 1;
		state <= 6'd18;
	end
	// XOR value at register SR1 with IR[4:0] or SR2, store result into DR, set CC's
	6'd9: begin
		sr1 <= ir[8:6];
		sr2 <= ir[2:0];
		if (ir[5])
			sr2mux <= 1;
		else
			sr2mux <= 0;
		aluk <= 2'd2;
		dr <= ir[11:9];
		gatealu <= 1;
		ldreg <= 1;
		ldcc <= 1;
		state <= 6'd18;
	end
	// Shift value at register SR1 by IR[3:0] with direction D and arithmetic A, set CC's
	6'd13: begin
		gateshf <= 1;
		sr1 <= ir[8:6];
		ldreg <= 1;
		dr <= ir[11:9];
		ldcc <= 1;
		state <= 6'd18;
	end
	// Address is computed by adding PCoffset9 with PC, then loaded into DR, set CC's
	6'd14: begin
		ldreg <= 1;
		dr <= ir[11:9];
		addr2mux <= 1;
		addr1mux <= 1;
		marmux <= 1;
		gatemarmux <= 1;
		ldcc <= 1;
		state <= 6'd18;
	end
	// Address is computed by adding LSHF(off6,1) with the value at SR1, then loaded into MAR
	6'd6: begin
		ldmar <= 1;
		sr1 <= ir[8:6];
		addr1mux <= 1;
		addr2mux <= 2'd2;
		marmux <= 1;
		gatemarmux <= 1;
		state <= 6'd25;
	end
	// Load memory contents at MAR into MDR, wait for R
	6'd25: begin
		ldmdr <= 1;
		if (r)
			state <= 6'd27;
		else
			state <= 6'd25;
	end
	// Load MDR into DR, set CC's
	6'd27: begin
		dr <= ir[11:9];
		ldreg <= 1;
		ldcc <= 1;
		gatemdr <= 1;
		state <= 6'd18;
	end
	// Address is computed by adding LSHF(off6,1) with the value at SR1, then loaded into MAR
	6'd10: begin
		ldmar <= 1;
		gatemarmux <= 1;
		marmux <= 1;
		addr1mux <= 1;
		addr2mux <= 2'd2;
		sr1 <= ir[8:6];
		ldcc <= 1;
		state <= 6'd36;
	end
	// Load address at the memory contents of MAR into MDR, wait for R
	6'd36: begin
		ldmdr <= 1;
		if (r)
			state <= 6'd37;
		else
			state <= 6'd36;
	end
	// Load MDR into MAR
	6'd37: begin
		gatemdr <= 1;
		ldmar <= 1;
		state <= 6'd25;
	end
	// Address is computed by adding LSHF(off6,1) with the value at SR1, then loaded into MAR
	6'd7: begin
		ldmar <= 1;
		gatemarmux <= 1;
		marmux <= 1;
		addr1mux <= 1;
		addr2mux <= 2'd2;
		sr1 <= ir[8:6];
		state <= 6'd23;
	end
	// Load the value at register SR1 into MDR
	6'd23: begin
		ldmdr <= 1;
		sr1 <= ir[8:6];
		aluk <= 2'd3;
		gatealu <= 1;
		state <= 6'd16;
	end
	// Save MDR to M[MAR], wait for R
	6'd16: begin
		rw <= 1;
		if (r)
			state <= 6'd18;
		else
			state <= 6'd16;
	end
	// Address is computed by adding LSHF(off6,1) with the value at SR1, then loaded into MAR
	6'd11: begin
		ldmar <= 1;
		gatemarmux <= 1;
		marmux <= 1;
		addr2mux <= 2'd2;
		addr1mux <= 1;
		sr1 <= ir[8:6];
		state <= 6'd38;
	end
	// Load memory contents at MAR into MDR, wait for R
	6'd38: begin
		ldmdr <= 1;
		if (r)
			state <= 6'd39;
		else
			state <= 6'd38;
	end
	// Load MDR into MAR
	6'd39: begin
		gatemdr <= 1;
		ldmar <= 1;
		state <= 6'd23;
	end
	// Advance to state 20 or 21 based on IR[11]
	6'd4: begin
		if (ir[11])
			state <= 6'd21;
		else
			state <= 6'd20;
	end
	// Store PC into register R7, load SR1 into PC *****
	6'd20: begin
		ldreg <= 1;
		dr <= 3'd7;
		sr1 <= ir[8:6];
		ldpc <= 1;
		gatepc <= 1;
		addr1mux <= 0;
		addr2mux <= 2'd3;
		pcmux <= 1;
		state <= 6'd18;
	end
	// Store PC into register R7, increment PC by LSHF(off11,1)
	6'd21: begin
		ldreg <= 1;
		dr <= 3'd7;
		ldpc <= 1;
		gatepc <= 1;
		addr1mux <= 0;
		addr2mux <= 0;
		pcmux <= 1;
		ldpc <= 1;
		state <= 6'd18;
	end
	// Add the value at register SR1 with off6, load into MAR, set CC's
	6'd2: begin
		ldmar <= 1;
		lshf <= 1;
		sr1 <= ir[8:6];
		addr1mux <= 0;
		addr2mux <= 2'd2;
		marmux <= 1;
		gatemarmux <= 1;
		ldcc <= 1;
		state <= 6'd29;
	end
	// Load the byte contents of memory at MAR into MDR, wait for R
	6'd29: begin
		ldmdr <= 1;
		datasize <= 1;
		if (r)
			state <= 6'd31;
		else
			state <= 6'd29;
	end
	// Load the sign-extended byte at MDR into DR, set CC's
	6'd31: begin
		ldreg <= 1;
		dr <= ir[11:9];
		ldcc <= 1;
		gatemdr <= 1;
		state <= 6'd18;
	end
	// Add the value at register SR1 with off6, load into MAR, set CC's
	6'd3: begin
		ldmar <= 1;
		lshf <= 1;
		sr1 <= ir[8:6];
		addr1mux <= 0;
		addr2mux <= 2'd2;
		marmux <= 1;
		gatemarmux <= 1;
		ldcc <= 1;
		state <= 6'd24;
	end
	// Load the byte contents at register SR1 (SR[7:0]) into MDR
	6'd24: begin
		ldmdr <= 1;
		sr1 <= ir[8:6];
		aluk <= 2'd3;
		gatealu <= 1;
		state <= 6'd17;
	end
	// Save the sign-extended byte at MDR[15:8] or MDR[7:0] to M[MAR], wait for R
	6'd17: begin
		rw <= 1;
		if (r)
			state <= 6'd17;
		else
			state <= 6'd18;
	end
endcase
end
endmodule