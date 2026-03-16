module createKeys (
    input [9:0] bin,
    output reg [7:0] keyOne,
	 output reg [7:0] keyTwo
);

reg [9:0] scramble;
reg [9:0] oneShift;
reg [9:0] twoShift;

always @ (bin) 
begin
    // Scramble the input bits according to the given pattern
    scramble = {bin[7], bin[5], bin[8], bin[3], bin[6], bin[0], bin[9], bin[1], bin[2], bin[4]};

    // Shift operations
    oneShift[9:5] = {scramble[8:5], scramble[9]};
    oneShift[4:0] = {scramble[3:0], scramble[4]};

    twoShift[9:5] = {oneShift[7:5], oneShift[9:8]};
    twoShift[4:0] = {oneShift[2:0], oneShift[4:3]};

    // Generate keyOne and keyTwo
    keyOne = {oneShift[4], oneShift[7], oneShift[3], oneShift[6], oneShift[2], oneShift[5], oneShift[0], oneShift[1]};
    keyTwo = {twoShift[4], twoShift[7], twoShift[3], twoShift[6], twoShift[2], twoShift[5], twoShift[0], twoShift[1]};
end

endmodule