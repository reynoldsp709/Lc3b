library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        clock_50        : in     vl_logic;
        \in\            : in     vl_logic_vector(15 downto 0);
        load            : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end pc;
