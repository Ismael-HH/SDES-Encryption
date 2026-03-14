//============================================================
// SDES Decryption Module
//
// This module performs the SDES decryption process
// on an 8-bit ciphertext input using two generated
// 8-bit subkeys.
//
// The encryption process follows these main steps:
//
// 1. Initial permutation of the ciphertext
// 2. First Feistel round using key two
// 3. S-Box substitution and permutation
// 4. XOR with the left half of the data
// 5. Second Feistel round using key one
// 6. Final permutation to generate the plaintext
//
// All operations occur combinationally whenever the input
// ciphertext changes.
//============================================================
module decrypt(
	input [7:0]data,
	input [7:0]keyOne,
	input [7:0]keyTwo,
	output reg[7:0]cipher
);

//============================================================
// Internal registers
//============================================================
reg [7:0] scrambleOne;            // Initial permutation result
reg [7:0] four2EightScramble;     // Expansion/permutation of right half
reg [7:0] xorResult;              // XOR result with keyOne
reg [1:0] S0Out;                  // Output of S0 substitution box
reg [1:0] S1Out;                  // Output of S1 substitution box
reg [3:0] sOut;                   // Combined S-box output
reg [3:0] fourBitScramble;        // Permuted S-box output
reg [3:0] xorTwoResult;           // XOR with left half

reg [7:0] four2EightScrambleTwo;  // Expansion for second round
reg [7:0] xorThreeResult;         // XOR with keyTwo

reg [3:0] sOutTwo;                // Second S-box output
reg [1:0] s0Row;
reg [1:0] s0Col;
reg [1:0] s1Row;
reg [1:0] s1Col;

reg [3:0] fourBitScrambleTwo;     // Second permutation
reg [3:0] xorfourResult;          // XOR with left half
reg [7:0] scrambleTwo;            // Final permutation

//============================================================
// Encryption Logic
//============================================================

always @(data)
	begin
	// Step 1: Initial Permutation (IP)
	// Rearranges the plaintext bits before the Feistel rounds.
		scrambleOne = {data[6], data[2], data[5], data[7], data[4], data[0], data[3], data[1]};

	// Step 2: Expand and Permute the Right Half
	// The right 4 bits are expanded to 8 bits to prepare
	// for XOR with the first subkey.
		four2EightScramble = {scrambleOne[0], scrambleOne[3], scrambleOne[2], scrambleOne[1], scrambleOne[2], scrambleOne[1], scrambleOne[0], scrambleOne[3]};

	// Step 3: XOR with First Subkey
		xorResult = four2EightScramble ^ keyTwo;

	// Step 4: S-Box Substitution
	// The XOR result is split and processed through S0 and S1
	// substitution boxes which compress 4 bits into 2 bits.
		s0Row = {xorResult[7], xorResult[4]};
		s0Col = {xorResult[6], xorResult[5]};  
		s1Row = {xorResult[3], xorResult[0]};
		s1Col = {xorResult[2], xorResult[1]};

		// S0 substitution lookup
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
		// S1 substitution lookup
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

	// Step 5: Combine S-box outputs and permute
		sOut = {S0Out, S1Out};		
		fourBitScramble[3:0]={sOut[2], sOut[0], sOut[1], sOut[3]};
	
	// Step 6: XOR with left half (Feistel function)
		xorTwoResult = fourBitScramble ^ scrambleOne[7:4];
	
	// Step 7: Second Feistel Round using keyTwo
		four2EightScrambleTwo = {xorTwoResult[0], xorTwoResult[3], xorTwoResult[2], xorTwoResult[1], xorTwoResult[2], xorTwoResult[1], xorTwoResult[0], xorTwoResult[3]};
		xorThreeResult = four2EightScrambleTwo ^ keyOne;

	// Step 8: Second S-box substitution
		s0Row = {xorThreeResult[7], xorThreeResult[4]};
		s0Col = {xorThreeResult[6], xorThreeResult[5]};  
		s1Row = {xorThreeResult[3], xorThreeResult[0]};
		s1Col = {xorThreeResult[2], xorThreeResult[1]};

		// S0 substitution lookup
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
		// S1 substitution lookup
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
	// Combine S-box output		
		sOutTwo = {S0Out, S1Out};
		
	// Step 9: Final permutation and recombination
		fourBitScrambleTwo[3:0]={sOutTwo[2], sOutTwo[0], sOutTwo[1], sOutTwo[3]};
		xorfourResult = scrambleOne[3:0] ^ fourBitScrambleTwo;
	
	// Step 10: Final permutation producing ciphertext
		scrambleTwo = {xorfourResult[0], xorfourResult[3], xorfourResult[1], xorTwoResult[3], xorTwoResult[1], xorfourResult[2], xorTwoResult[0], xorTwoResult[2]};	
		cipher = scrambleTwo;
	end	
endmodule  