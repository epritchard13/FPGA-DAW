`timescale 1ns/1ns

module spi_loopback_test();

logic clk;
logic sclk;
logic reset;

logic cs;
logic mosi;
logic miso;
logic sck;

logic di_req;
logic [7:0] di;
logic wren;
logic wr_ack;
logic do_valid;
logic [7:0] dout;

logic sl_do_valid;
logic [7:0] sl_dout;
logic sl_di_req;
logic [7:0] sl_di = 8'h10;
logic sl_wren_i = 0;


// drive clock and reset
initial begin
    //$dumpfile("spi_loopback_test.vcd");
    //$dumpvars();
    clk = 0;
    forever begin
        #4 clk = ~clk;
    end
end

initial begin
    sclk = 0;
    forever begin
        #2 sclk = ~sclk;
    end
end

initial begin
    reset = 1;
    #10 reset = 0;
end

initial begin
    di = 8'h10;
end

always @(posedge clk) begin
    wren <= 0;
    if (!reset)
        @ (posedge di_req) begin
            di <= di + 1;
            wren <= 1;
        end
end

always @(posedge clk) begin
    if (!reset)
        @ (posedge sl_di_req) begin
            sl_di <= sl_di + 1;
        end
end

/*
entity spi_slave is
    Generic (   
        N : positive := 8;                                             -- 32bit serial word length is default
        CPOL : std_logic := '0';                                        -- SPI mode selection (mode 0 default)
        CPHA : std_logic := '0';                                        -- CPOL = clock polarity, CPHA = clock phase.
        PREFETCH : positive := 3);                                      -- prefetch lookahead cycles
    Port (  
        clk_i : in std_logic := 'X';                                    -- internal interface clock (clocks di/do registers)
        spi_ssel_i : in std_logic := 'X';                               -- spi bus slave select line
        spi_sck_i : in std_logic := 'X';                                -- spi bus sck clock (clocks the shift register core)
        spi_mosi_i : in std_logic := 'X';                               -- spi bus mosi input
        spi_miso_o : out std_logic := 'X';                              -- spi bus spi_miso_o output
        di_req_o : out std_logic;                                       -- preload lookahead data request line
        di_i : in  std_logic_vector (N-1 downto 0) := (others => 'X');  -- parallel load data in (clocked in on rising edge of clk_i)
        wren_i : in std_logic := 'X';                                   -- user data write enable
        wr_ack_o : out std_logic;                                       -- write acknowledge
        do_valid_o : out std_logic;                                     -- do_o data valid strobe, valid during one clk_i rising edge.
        do_o : out  std_logic_vector (N-1 downto 0);                    -- parallel output (clocked out on falling clk_i)
        --- debug ports: can be removed for the application circuit ---
        do_transfer_o : out std_logic;                                  -- debug: internal transfer driver
        wren_o : out std_logic;                                         -- debug: internal state of the wren_i pulse stretcher
        rx_bit_next_o : out std_logic;                                  -- debug: internal rx bit
        state_dbg_o : out std_logic_vector (3 downto 0);                -- debug: internal state register
        sh_reg_dbg_o : out std_logic_vector (N-1 downto 0)              -- debug: internal shift register
    );                      
end spi_slave;
*/
spi_master spi_master0(
    .sclk_i(sclk),
    .pclk_i(clk),
    .rst_i(reset),

    .spi_ssel_o(cs),
    .spi_sck_o(sck),
    .spi_mosi_o(mosi),
    .spi_miso_i(miso),

    .di_req_o(di_req),
    .di_i(di),
    .wren_i(wren),
    .wr_ack_o(wr_ack),
    .do_valid_o(do_valid),
    .do_o(dout)
);

spi_slave spi_slave0(
    .clk_i(clk),
    .spi_ssel_i(cs),
    .spi_sck_i(sck),
    .spi_mosi_i(mosi),
    .spi_miso_o(miso),

    .do_valid_o(sl_do_valid),
    .do_o(sl_dout),

    .di_req_o(sl_di_req),
    .di_i(sl_di),
    .wren_i(sl_di_req)
);

endmodule