module sextfnc ();

function sign_extend;
input [7:0] temp_in;
begin
	sign_extend = {{8{temp_in[7]}}, temp_in[7:0]};
end
endfunction

endmodule