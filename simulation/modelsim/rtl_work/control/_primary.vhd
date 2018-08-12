library verilog;
use verilog.vl_types.all;
entity control is
    port(
        clk_50          : in     vl_logic;
        r               : in     vl_logic;
        ir              : in     vl_logic_vector(15 downto 0);
        \bus\           : in     vl_logic_vector(15 downto 0);
        pcmux           : out    vl_logic_vector(1 downto 0);
        addr1mux        : out    vl_logic;
        addr2mux        : out    vl_logic_vector(1 downto 0);
        sr2mux          : out    vl_logic;
        marmux          : out    vl_logic;
        aluk            : out    vl_logic_vector(1 downto 0);
        sr1             : out    vl_logic_vector(2 downto 0);
        sr2             : out    vl_logic_vector(2 downto 0);
        ldmar           : out    vl_logic;
        ldmdr           : out    vl_logic;
        ldpc            : out    vl_logic;
        ldir            : out    vl_logic;
        ldcc            : out    vl_logic;
        ldreg           : out    vl_logic;
        gatepc          : out    vl_logic;
        gatemdr         : out    vl_logic;
        gatealu         : out    vl_logic;
        gateshf         : out    vl_logic;
        gatemarmux      : out    vl_logic;
        rw              : out    vl_logic;
        datasize        : out    vl_logic;
        dr              : out    vl_logic_vector(2 downto 0);
        lshf            : out    vl_logic
    );
end control;
