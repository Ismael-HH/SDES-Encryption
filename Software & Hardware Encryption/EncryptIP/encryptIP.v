module encryptIP (
	input [1:0] address,
	input chipselect,
	input clk,
	input read,
	input reset_n,
	input write,
	input [31:0] writedata,
	output reg [31:0] readdata
);

reg [9:0] bin;
wire [7:0] keyOne;
wire [7:0] keyTwo;

reg [7:0] data;
wire [7:0] cipher;

reg [7:0] cipherData;
wire [7:0] encryptdata;


createKeys keys(bin, keyOne, keyTwo);
encryptS encryption(data, keyOne, keyTwo, cipher);
decrypt decryption(cipherData, keyOne, keyTwo, encryptdata);

always @(posedge clk or negedge reset_n) 
	begin
		if (!reset_n) 
			begin
				bin <= 10'b0;
				data <= 10'b0; 
				cipherData <= 10'b0; 
				readdata <= 32'b0;
			end
		else if (chipselect && write && (address == 2'b00)) 
			begin
				bin <= writedata[9:0]; 
				readdata <= 32'b0;
			end
		else if (chipselect && write && (address == 2'b01)) 
			begin
				data <= writedata[7:0]; 
				readdata <= 32'b0;
			end
		else if (chipselect && write && (address == 2'b10)) 
			begin
				cipherData <= cipher; 
				readdata <= 32'b0;
			end
		else if (chipselect && read) 
			begin
				case (address)
					2'b00: readdata <= {22'b0, bin};       
					2'b01: readdata <= {18'b0, keyOne, keyTwo};     
					2'b10: readdata <= {24'b0, cipher};
					2'b11: readdata <= {24'b0, encryptdata};
					default: readdata <= 32'b0;
				endcase
			end
			
	end
endmodule