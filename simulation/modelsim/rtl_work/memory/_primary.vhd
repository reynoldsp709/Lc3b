library verilog;
use verilog.vl_types.all;
entity memory is
    port(
        clk_50          : in     vl_logic;
        \bus\           : inout  vl_logic_vector(15 downto 0);
        ldMar           : in     vl_logic;
        ldMdr           : in     vl_logic;
        datasize        : in     vl_logic;
        rw              : in     vl_logic;
        r               : out    vl_logic;
        mdr             : out    vl_logic_vector(15 downto 0)
    );
end memory;
