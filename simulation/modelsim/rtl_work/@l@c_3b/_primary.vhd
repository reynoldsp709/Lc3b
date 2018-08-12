library verilog;
use verilog.vl_types.all;
entity LC_3b is
    port(
        CLOCK_50        : in     vl_logic;
        LED             : out    vl_logic_vector(7 downto 0);
        KEY             : in     vl_logic_vector(1 downto 0);
        SW              : in     vl_logic_vector(3 downto 0);
        GPIO_2          : inout  vl_logic_vector(12 downto 0);
        GPIO_2_IN       : in     vl_logic_vector(2 downto 0);
        GPIO0           : inout  vl_logic_vector(33 downto 0);
        GPIO0_IN        : in     vl_logic_vector(1 downto 0);
        GPIO1           : inout  vl_logic_vector(33 downto 0);
        GPIO1_IN        : in     vl_logic_vector(1 downto 0)
    );
end LC_3b;
