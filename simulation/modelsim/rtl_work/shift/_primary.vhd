library verilog;
use verilog.vl_types.all;
entity shift is
    port(
        a               : in     vl_logic;
        d               : in     vl_logic;
        amt             : in     vl_logic_vector(3 downto 0);
        \in\            : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end shift;
