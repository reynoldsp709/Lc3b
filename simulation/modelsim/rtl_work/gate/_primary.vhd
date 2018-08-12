library verilog;
use verilog.vl_types.all;
entity gate is
    port(
        enable          : in     vl_logic;
        \in\            : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end gate;
