library verilog;
use verilog.vl_types.all;
entity sext is
    generic(
        WIDTH           : integer := 7
    );
    port(
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end sext;
