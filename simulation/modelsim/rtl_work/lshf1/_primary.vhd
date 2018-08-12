library verilog;
use verilog.vl_types.all;
entity lshf1 is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        enable          : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end lshf1;
