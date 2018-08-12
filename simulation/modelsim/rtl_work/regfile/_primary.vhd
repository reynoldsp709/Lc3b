library verilog;
use verilog.vl_types.all;
entity regfile is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        clk_50          : in     vl_logic;
        sr1             : in     vl_logic_vector(2 downto 0);
        sr2             : in     vl_logic_vector(2 downto 0);
        dr              : in     vl_logic_vector(2 downto 0);
        ldreg           : in     vl_logic;
        sr1_out         : out    vl_logic_vector(15 downto 0);
        sr2_out         : out    vl_logic_vector(15 downto 0)
    );
end regfile;
