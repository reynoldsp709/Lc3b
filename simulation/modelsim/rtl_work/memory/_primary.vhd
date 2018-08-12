library verilog;
use verilog.vl_types.all;
entity memory is
    port(
        clk_50          : in     vl_logic;
        \bus\           : in     vl_logic;
        ldMar           : in     vl_logic;
        ldMdr           : in     vl_logic;
        datasize        : in     vl_logic;
        rw              : in     vl_logic;
        r               : out    vl_logic
    );
end memory;
