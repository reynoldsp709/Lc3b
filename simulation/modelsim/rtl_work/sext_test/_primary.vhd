library verilog;
use verilog.vl_types.all;
entity sext_test is
    generic(
        WIDTH           : integer := 7
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end sext_test;
