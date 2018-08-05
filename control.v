/* Module: control();
*
*  Parameter:
*      In:
*      Out:
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
	ldmdr,
	ldcc,
	ldreg,
	ben,
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
output reg [1:0] pcmux;
output reg addr1mux;
output reg [1:0] addr2mux;
output reg sr2mux;
output reg marmux;
output reg aluk;
output reg [2:0] sr1;
output reg [2:0] sr2;
output reg [2:0] dr;
reg [5:0] state;
output reg n, z, p, ldmar, ldmdr, ldpc, ldir, ldcc, ldreg, ben, gatepc, gatemdr, gatealu, gateshf, gatemarmux, rw, datasize, lshf;

always @(posedge clk_50) begin
	if (ldcc == 1) begin
		if (bus < 0)
			n <= 1;
		else if (bus == 0)
			z <= 1;
		else if (bus > 0)
			p <= 1;
	end
	case(state)
	6'd18: begin
		gatepc <= 1;
		ldmar <= 1;
		state <= 6'd19;
	end
	6'd19: begin
		ldpc <= 1;
		state <= 6'd33;
	end
	6'd33: begin
		ldmdr <= 1;
		if (r)
			state <= 6'd35;
		else
			state <= 6'd33;
	end
	6'd35: begin
		ldir <= 1;
		gatemdr <= 1;
		state <= 6'd32;
	end
	6'd32: begin
		ben <= ((ir[11] & n) | (ir[10] & z) | (ir[9] & p));
		state <= ir[15:12];
	end
	6'd0: begin
		if (ben)
			state <= 6'd22;
		else
			state <= 6'd18;
	end
	6'd22: begin
		ldpc <= 1;
		addr1mux <= 0;
		addr2mux <= 1;
		pcmux <= 1;
		state <= 6'd18;
	end
	6'd12: begin
		ldpc <= 1;
		pcmux <= 0;
		gatealu <= 1;
		aluk <= 2'd3;
		sr1 <= ir[8:6];
		state <= 6'd18;
	end
	6'd1: begin
		sr1 <= ir[8:6];
		if (ir[5])
			sr2mux <= 1;
		else
			sr2mux <= 0;
		aluk <= 0;
		dr <= ir[11:9];
		gatealu <= 1;
		ldreg <= 1;
		ldcc <= 1;
		sr2 <= ir[2:0];
		state <= 6'd18;
	end
	6'd5: begin
		sr1 <= ir[8:6];
		if (ir[5])
			sr2mux <= 1;
		else
			sr2mux <= 0;
		aluk <= 1;
		dr <= ir[11:9];
		gatealu <= 1;
		ldreg <= 1;
		ldcc <= 1;
		sr2 <= ir[2:0];
		state <= 6'd18;
	end
	6'd9: begin
		sr1 <= ir[8:6];
		if (ir[5])
			sr2mux <= 1;
		else
			sr2mux <= 0;
		aluk <= 2'd2;
		dr <= ir[11:9];
		gatealu <= 1;
		ldreg <= 1;
		ldcc <= 1;
		sr2 <= ir[2:0];
		state <= 6'd18;
	end
	6'd13: begin
		gateshf <= 1;
		sr1 <= ir[8:6];
		ldreg <= 1;
		dr <= ir[11:9];
		ldcc <= 1;
		state <= 6'd18;
	end
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
	6'd6: begin
		ldmar <= 1;
		sr1 <= ir[8:6];
		addr1mux <= 1;
		addr2mux <= 2'd2;
		marmux <= 1;
		gatemarmux <= 1;
		state <= 6'd25;
	end
	6'd25: begin
		ldmdr <= 1;
		if (r)
			state <= 6'd27;
		else
			state <= 6'd25;
	end
	6'd27: begin
		dr <= ir[11:9];
		ldreg <= 1;
		ldcc <= 1;
		gatemdr <= 1;
		state <= 6'd18;
	end
	6'd10: begin
		ldmar <= 1;
		gatemarmux <= 1;
		marmux <= 1;
		addr2mux <= 2'd2;
		addr1mux <= 1;
		sr1 <= ir[8:6];
		ldcc <= 1;
		state <= 6'd36;
	end
	6'd36: begin
		ldmdr <= 1;
		if (r)
			state <= 6'd37;
		else
			state <= 6'd36;
	end
	6'd37: begin
		gatemdr <= 1;
		ldmar <= 1;
		state <= 6'd25;
	end
	6'd7: begin
		ldmar <= 1;
		gatemarmux <= 1;
		marmux <= 1;
		addr2mux <= 2'd2;
		addr1mux <= 1;
		sr1 <= ir[8:6];
		state <= 6'd23;
	end
	6'd23: begin
		ldmdr <= 1;
		sr1 <= ir[8:6];
		aluk <= 2'd3;
		gatealu <= 1;
		state <= 6'd16;
	end
	6'd16: begin
		rw <= 1;
		if (r)
			state <= 6'd18;
		else
			state <= 6'd16;
	end
	6'd11: begin
		gatemarmux <= 1;
		marmux <= 1;
		addr2mux <= 2'd2;
		addr1mux <= 1;
		sr1 <= ir[8:6];
		state <= 6'd38;
	end
	6'd38: begin
		ldmdr <= 1;
		if (r)
			state <= 6'd39;
		else
			state <= 6'd38;
	end
	6'd39: begin
		gatemdr <= 1;
		ldmar <= 1;
		state <= 6'd23;
	end
	6'd4: begin
		if (ir[11])
			state <= 6'd21;
		else
			state <= 6'd20;
	end
	6'd20: begin
		ldreg <= 1;
		dr <= 3'd7;
		ldpc <= 1;
		gatepc <= 1;
		addr1mux <= 1;
		addr2mux <= 2'd3;
		pcmux <= 1;
		ldpc <= 1;
		state <= 6'd18;
	end
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
	6'd2: begin
		ldmar <= 1;
		lshf <= 1;
		addr1mux <= 0;
		addr2mux <= 2'd2;
		marmux <= 1;
		gatemarmux <= 1;
		ldcc <= 1;
		state <= 6'd29;
	end
	6'd29: begin
		ldmdr <= 1;
		datasize <= 1;
		if (r)
			state <= 6'd31;
		else
			state <= 6'd29;
	end
	6'd31: begin
		ldreg <= 1;
		dr <= ir[11:9];
		ldcc <= 1;
		gatemdr <= 1;
		state <= 6'd18;
	end
	6'd3: begin
		ldmar <= 1;
		lshf <= 1;
		addr1mux <= 0;
		addr2mux <= 2'd2;
		marmux <= 1;
		gatemarmux <= 1;
		ldcc <= 1;
		state <= 6'd24;
	end
	6'd24: begin
		ldmdr <= 1;
		sr1 <= ir[8:6];
		aluk <= 2'd3;
		gatealu <= 1;
		state <= 6'd17;
	end
endcase
end
endmodule