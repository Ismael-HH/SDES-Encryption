module decrypt(
	input [7:0]data,
	input [7:0]keyOne,
	input [7:0]keyTwo,
	output reg[7:0]cipher
);

reg [7:0] scrambleOne;
reg [7:0] four2EightScramble;
reg [7:0] xorResult;
reg [1:0] S0Out;
reg [1:0] S1Out;
reg [3:0] sOut;
reg [3:0] fourBitScramble;
reg [3:0] xorTwoResult;
reg [7:0] four2EightScrambleTwo;
reg [7:0] xorThreeResult;
reg [3:0] sOutTwo;
reg [1:0] s0Row;
reg [1:0] s0Col;
reg [1:0] s1Row;
reg [1:0] s1Col;
reg [3:0] fourBitScrambleTwo;
reg [3:0] xorfourResult;
reg [7:0] scrambleTwo;

always @(data)
	begin
		scrambleOne = {data[6], data[2], data[5], data[7], data[4], data[0], data[3], data[1]};

		four2EightScramble = {scrambleOne[0], scrambleOne[3], scrambleOne[2], scrambleOne[1], scrambleOne[2], scrambleOne[1], scrambleOne[0], scrambleOne[3]};

		// XOR the scrambled data with the key
		xorResult = four2EightScramble ^ keyTwo;

		// Compile the S0 and S1 values from the result
		s0Row = {xorResult[7], xorResult[4]};
		s0Col = {xorResult[6], xorResult[5]};  
		s1Row = {xorResult[3], xorResult[0]};
		s1Col = {xorResult[2], xorResult[1]};

		// S0 Case Statement
		case ({s0Row, s0Col})
			4'b0000: S0Out = 2'b01;
			4'b0001: S0Out = 2'b00;
			4'b0010: S0Out = 2'b11;
			4'b0011: S0Out = 2'b10;
			4'b0100: S0Out = 2'b11;
			4'b0101: S0Out = 2'b10;
			4'b0110: S0Out = 2'b01;
			4'b0111: S0Out = 2'b00;
			4'b1000: S0Out = 2'b00;
			4'b1001: S0Out = 2'b10;
			4'b1010: S0Out = 2'b01;
			4'b1011: S0Out = 2'b11;
			4'b1100: S0Out = 2'b11;
			4'b1101: S0Out = 2'b01;
			4'b1110: S0Out = 2'b11;
			4'b1111: S0Out = 2'b10;
			default: S0Out = 2'b00;
		endcase
		// S1 Case Statement
		case ({s1Row, s1Col})
			4'b0000: S1Out = 2'b00;
			4'b0001: S1Out = 2'b01;
			4'b0010: S1Out = 2'b10;
			4'b0011: S1Out = 2'b11;
			4'b0100: S1Out = 2'b10;
			4'b0101: S1Out = 2'b00;
			4'b0110: S1Out = 2'b01;
			4'b0111: S1Out = 2'b11;
			4'b1000: S1Out = 2'b11;
			4'b1001: S1Out = 2'b00;
			4'b1010: S1Out = 2'b01;
			4'b1011: S1Out = 2'b00;
			4'b1100: S1Out = 2'b10;
			4'b1101: S1Out = 2'b01;
			4'b1110: S1Out = 2'b00;
			4'b1111: S1Out = 2'b11;
			default: S1Out = 2'b00;
		endcase

		sOut = {S0Out, S1Out};		

		fourBitScramble[3:0]={sOut[2], sOut[0], sOut[1], sOut[3]};

		xorTwoResult = fourBitScramble ^ scrambleOne[7:4];

		four2EightScrambleTwo = {xorTwoResult[0], xorTwoResult[3], xorTwoResult[2], xorTwoResult[1], xorTwoResult[2], xorTwoResult[1], xorTwoResult[0], xorTwoResult[3]};

		// XOR the scrambled data with key 2
		xorThreeResult = four2EightScrambleTwo ^ keyOne;

		// Compile the S0 and S1 values from the result
		s0Row = {xorThreeResult[7], xorThreeResult[4]};
		s0Col = {xorThreeResult[6], xorThreeResult[5]};  
		s1Row = {xorThreeResult[3], xorThreeResult[0]};
		s1Col = {xorThreeResult[2], xorThreeResult[1]};

		// S0 Case Statement
		case ({s0Row, s0Col})
			4'b0000: S0Out = 2'b01;
			4'b0001: S0Out = 2'b00;
			4'b0010: S0Out = 2'b11;
			4'b0011: S0Out = 2'b10;
			4'b0100: S0Out = 2'b11;
			4'b0101: S0Out = 2'b10;
			4'b0110: S0Out = 2'b01;
			4'b0111: S0Out = 2'b00;
			4'b1000: S0Out = 2'b00;
			4'b1001: S0Out = 2'b10;
			4'b1010: S0Out = 2'b01;
			4'b1011: S0Out = 2'b11;
			4'b1100: S0Out = 2'b11;
			4'b1101: S0Out = 2'b01;
			4'b1110: S0Out = 2'b11;
			4'b1111: S0Out = 2'b10;
			default: S0Out = 2'b00;
		endcase
		// S1 Case Statement
		case ({s1Row, s1Col})
			4'b0000: S1Out = 2'b00;
			4'b0001: S1Out = 2'b01;
			4'b0010: S1Out = 2'b10;
			4'b0011: S1Out = 2'b11;
			4'b0100: S1Out = 2'b10;
			4'b0101: S1Out = 2'b00;
			4'b0110: S1Out = 2'b01;
			4'b0111: S1Out = 2'b11;
			4'b1000: S1Out = 2'b11;
			4'b1001: S1Out = 2'b00;
			4'b1010: S1Out = 2'b01;
			4'b1011: S1Out = 2'b00;
			4'b1100: S1Out = 2'b10;
			4'b1101: S1Out = 2'b01;
			4'b1110: S1Out = 2'b00;
			4'b1111: S1Out = 2'b11;
			default: S1Out = 2'b00;
		endcase
				
		sOutTwo = {S0Out, S1Out};
		
		fourBitScrambleTwo[3:0]={sOutTwo[2], sOutTwo[0], sOutTwo[1], sOutTwo[3]};

		xorfourResult = scrambleOne[3:0] ^ fourBitScrambleTwo;
		
		scrambleTwo = {xorfourResult[0], xorfourResult[3], xorfourResult[1], xorTwoResult[3], xorTwoResult[1], xorfourResult[2], xorTwoResult[0], xorTwoResult[2]};
		
		cipher = scrambleTwo;
	end	
endmodule  