//============================================================
// SDES Key Generation Module
//
// This module generates two 8-bit subkeys (keyOne and keyTwo)
// from a 10-bit input key. The process follows the simplified
// SDES key scheduling steps:
//
// 1. Apply an initial permutation (scramble) to the 10-bit key.
// 2. Perform circular left shifts.
// 3. Select and reorder bits to create the first subkey.
// 4. Select and reorder bits again to create the second subkey.
//
// Whenever the input key changes, the subkeys are automatically
// recomputed.
//============================================================
module createKeys (
    input [9:0] bin,
    output reg [7:0] keyOne,
	 output reg [7:0] keyTwo
);

//============================================================
// Internal Registers
//============================================================
reg [9:0] scramble; // Holds permuted version of the input key
reg [9:0] oneShift; // Result after one digit circular shift
reg [9:0] twoShift; // Result after two digit circular shift

always @ (bin) 
begin
    // Scramble the input bits according to the given pattern
    scramble = {bin[7], bin[5], bin[8], bin[3], bin[6], bin[0], bin[9], bin[1], bin[2], bin[4]};

    // Shift operations
    oneShift[9:5] = {scramble[8:5], scramble[9]};
    oneShift[4:0] = {scramble[3:0], scramble[4]};

    twoShift[9:5] = {oneShift[7:5], oneShift[9:8]};
    twoShift[4:0] = {oneShift[2:0], oneShift[4:3]};

    // Generate keyOne and keyTwo from permured input 
    keyOne = {oneShift[4], oneShift[7], oneShift[3], oneShift[6], oneShift[2], oneShift[5], oneShift[0], oneShift[1]};
    keyTwo = {twoShift[4], twoShift[7], twoShift[3], twoShift[6], twoShift[2], twoShift[5], twoShift[0], twoShift[1]};
end

endmodule