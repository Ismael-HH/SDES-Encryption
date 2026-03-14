//============================================================
// Top Level Module for SDES Encryption/Decryption System
// 
// This module connects the key generation, encryption,
// and decryption modules. Push buttons control when keys
// are generated, when encryption occurs, and when
// decryption occurs.
//
// Switch inputs provide:
//   - 10-bit key input
//   - 8-bit plaintext input
//
// Results are displayed on six seven-segment displays.
//============================================================
module encryptTopLevel (
	input clk,
	input reset,
	input [9:0] bin,
	input btnKey,
	input btnEncrypt,
	input btnDecrypt,
	output [6:0]keyOneOnesP,
	output [6:0]keyOnoSixteensP,
	output [6:0]keyTwoOnesP,
	output [6:0]KeyTwoSixteensP,
	output [6:0]ResultOnesP,
	output [6:0]ResultSixteensP
);

//============================================================
// Internal Registers and Wires
//============================================================
// Stores the 10-bit key input when the key button is pressed
reg 	[9:0] keyInput;

// Wires carrying the generated subkeys from the key generator
wire 	[7:0] keyOneWire;
wire 	[7:0] keyTwoWire;

// Stores the plaintext input used for encryption
reg 	[7:0] data;

// Output of the encryption module 
wire 	[7:0] cipher;

// Output of the decryption module
wire 	[7:0] deencryptdata;

// Determines what value is currently shown on the result displays
// (either ciphertext or decrypted plaintext)
reg 	[7:0]resultDisplay;

//============================================================
// Module Instantiations
//============================================================
// Generate the two SDES subkeys from the 10-bit key input
createKeys keys(keyInput, keyOneWire, keyTwoWire);

// Encrypt the plaintext using the generated keys
encryptS encryption(data, keyOneWire, keyTwoWire, cipher);

// Decrypt the stored ciphertext using the same keys
decrypt decryption(cipher, keyOneWire, keyTwoWire, deencryptdata);

// Display Key 1
sevenSeg hexFive(keyOneWire[3:0], keyOneOnesP);
sevenSeg hexFour(keyOneWire[7:4], keyOnoSixteensP);

// Display Key 2
sevenSeg hexThree(keyTwoWire[3:0], keyTwoOnesP);
sevenSeg hexTwo(keyTwoWire[7:4], KeyTwoSixteensP);

// Display encryption/decryption results
sevenSeg hexOne(resultDisplay[3:0], ResultOnesP);
sevenSeg hexZero(resultDisplay[7:4], ResultSixteensP);

//============================================================
// Control Logic
// Handles reset, key generation, encryption, and decryption
//============================================================
always @(posedge clk) 
	begin
	//---------------------------
	// Reset Condition
	// Clears stored values
	//---------------------------
		if (!reset) 
			begin
				keyInput 		<= 10'b0;
				data 				<= 8'b0;
				resultDisplay 	<= 8'b0;
			end
	//---------------------------
	// Key Generation
	// When btnKey is pressed:
	// - store switch input as key
	// - key generator module automatically creates keys
	// - display keys
	//---------------------------
		else if (!btnKey) 
			begin
				keyInput <= bin;
			end
			
	//---------------------------
	// Encryption Operation
	// When btnEncrypt is pressed:
	// - take lower 8 bits of switch input as plaintext
	// - encryption module produces ciphertext
	// - display ciphertext
	//---------------------------
		else if (!btnEncrypt) 
			begin
				data 				<= bin[7:0];
				resultDisplay 	<=cipher;
			end
			
	//---------------------------
	// Decryption Operation
	// When btnDecrypt is pressed:
	// - decrypt stored ciphertext
	// - display decrypted plaintext
	//---------------------------
		else if (!btnDecrypt) 
			begin
				resultDisplay 	<= deencryptdata;
			end		
	end
endmodule