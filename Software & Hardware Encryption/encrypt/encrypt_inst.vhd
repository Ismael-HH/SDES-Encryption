	component encrypt is
		port (
			button_export      : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			clk_clk            : in    std_logic                     := 'X';             -- clk
			displayhex0_export : out   std_logic_vector(6 downto 0);                     -- export
			displayhex1_export : out   std_logic_vector(6 downto 0);                     -- export
			displayhex2_export : out   std_logic_vector(6 downto 0);                     -- export
			displayhex3_export : out   std_logic_vector(6 downto 0);                     -- export
			displayhex4_export : out   std_logic_vector(6 downto 0);                     -- export
			displayhex5_export : out   std_logic_vector(6 downto 0);                     -- export
			leds_export        : out   std_logic_vector(9 downto 0);                     -- export
			sdram_clk_clk      : out   std_logic;                                        -- clk
			sdram_wire_addr    : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba      : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n   : out   std_logic;                                        -- cas_n
			sdram_wire_cke     : out   std_logic;                                        -- cke
			sdram_wire_cs_n    : out   std_logic;                                        -- cs_n
			sdram_wire_dq      : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm     : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n   : out   std_logic;                                        -- ras_n
			sdram_wire_we_n    : out   std_logic;                                        -- we_n
			switch_export      : in    std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component encrypt;

	u0 : component encrypt
		port map (
			button_export      => CONNECTED_TO_button_export,      --      button.export
			clk_clk            => CONNECTED_TO_clk_clk,            --         clk.clk
			displayhex0_export => CONNECTED_TO_displayhex0_export, -- displayhex0.export
			displayhex1_export => CONNECTED_TO_displayhex1_export, -- displayhex1.export
			displayhex2_export => CONNECTED_TO_displayhex2_export, -- displayhex2.export
			displayhex3_export => CONNECTED_TO_displayhex3_export, -- displayhex3.export
			displayhex4_export => CONNECTED_TO_displayhex4_export, -- displayhex4.export
			displayhex5_export => CONNECTED_TO_displayhex5_export, -- displayhex5.export
			leds_export        => CONNECTED_TO_leds_export,        --        leds.export
			sdram_clk_clk      => CONNECTED_TO_sdram_clk_clk,      --   sdram_clk.clk
			sdram_wire_addr    => CONNECTED_TO_sdram_wire_addr,    --  sdram_wire.addr
			sdram_wire_ba      => CONNECTED_TO_sdram_wire_ba,      --            .ba
			sdram_wire_cas_n   => CONNECTED_TO_sdram_wire_cas_n,   --            .cas_n
			sdram_wire_cke     => CONNECTED_TO_sdram_wire_cke,     --            .cke
			sdram_wire_cs_n    => CONNECTED_TO_sdram_wire_cs_n,    --            .cs_n
			sdram_wire_dq      => CONNECTED_TO_sdram_wire_dq,      --            .dq
			sdram_wire_dqm     => CONNECTED_TO_sdram_wire_dqm,     --            .dqm
			sdram_wire_ras_n   => CONNECTED_TO_sdram_wire_ras_n,   --            .ras_n
			sdram_wire_we_n    => CONNECTED_TO_sdram_wire_we_n,    --            .we_n
			switch_export      => CONNECTED_TO_switch_export       --      switch.export
		);

