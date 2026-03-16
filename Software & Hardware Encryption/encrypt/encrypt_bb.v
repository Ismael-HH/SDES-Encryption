
module encrypt (
	button_export,
	clk_clk,
	displayhex0_export,
	displayhex1_export,
	displayhex2_export,
	displayhex3_export,
	displayhex4_export,
	displayhex5_export,
	leds_export,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	switch_export);	

	input	[3:0]	button_export;
	input		clk_clk;
	output	[6:0]	displayhex0_export;
	output	[6:0]	displayhex1_export;
	output	[6:0]	displayhex2_export;
	output	[6:0]	displayhex3_export;
	output	[6:0]	displayhex4_export;
	output	[6:0]	displayhex5_export;
	output	[9:0]	leds_export;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input	[9:0]	switch_export;
endmodule
