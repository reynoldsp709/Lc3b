library verilog;
use verilog.vl_types.all;
entity mux2 is
    port(
        in0             : in     vl_logic_vector(15 downto 0);
        in1             : in     vl_logic_vector(15 downto 0);
        \select\        : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end mux2;
