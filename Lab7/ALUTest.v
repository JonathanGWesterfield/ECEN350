`timescale 1ns / 1ps
`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'h2}; #40; passTest({Zero, BusW}, 65'h0D91AC578, "ADD1, 2, 7F0C4B3F, 5A0E7A39", passed);
		{BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'h152672E37E, 4'h2}; #40; passTest({Zero, BusW}, 65'h097ECAC0A18, "ADD2, 2, 82C639269A, 152672E37E, 0, 97ECAC0A18", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'h2}; #40; passTest({Zero, BusW}, 65'h01C6174D719B3, "ADD3, 2, FA49D367EB2, CBCD7A09B01", passed);

		{BusA, BusB, ALUCtrl} = {64'h9C212C90E109EF50, 64'hAF93053C8CA68455, 4'h0}; #40; passTest({Zero, BusW}, 65'h08C01041080008450, "AND1, 0, 9C212C90E109EF50, AF93053C8CA68455", passed);
		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'h0}; #40; passTest({Zero, BusW}, 65'h05A0C4A39, "AND2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'h0}; #40; passTest({Zero, BusW}, 65'h0CA495201A00, "AND3", passed);

		{BusA, BusB, ALUCtrl} = {64'h9C212C90E109EF50, 64'hAF93053C8CA68455, 4'h1}; #40; passTest({Zero, BusW}, 65'h0BFB32DBCEDAFEF55, "ORR1", passed);
		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'h1}; #40; passTest({Zero, BusW}, 65'h07F0E7B3F, "ORR2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'h1}; #40; passTest({Zero, BusW}, 65'h0FBCDFB6FFB3, "ORR3", passed);

		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'b0110}; #40; passTest({Zero, BusW}, 65'h024FDD106, "SUB1", passed);
		{BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'h152672E37E, 4'b0110}; #40; passTest({Zero, BusW}, 65'h06D9FC6431C, "SUB2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'hCBCD7A09B01, 4'b0110}; #40; passTest({Zero, BusW}, 65'h02E7C595E3B1, "SUB3", passed);

		 {BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h5A0E7A39, 4'h7}; #40; passTest({Zero, BusW}, {1'b0,64'h5A0E7A39}, "PASS1", passed);
		 {BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'h152672E37E, 4'h7}; #40; passTest({Zero, BusW}, {1'b0,64'h152672E37E}, "PASS2", passed);
		 {BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'h0, 4'h7}; #40; passTest({Zero, BusW}, {1'b1,64'h0}, "PASS3", passed);

		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h1, 4'h3}; #40; passTest({Zero, BusW}, 65'h0FE18967E, "LSL1", passed);
		{BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'h8, 4'h3}; #40; passTest({Zero, BusW}, 65'h082C639269A00, "LSL2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'h8, 4'h3}; #40; passTest({Zero, BusW}, 65'h0FA49D367EB200, "LSL3", passed);

		{BusA, BusB, ALUCtrl} = {64'h7F0C4B3F, 64'h7, 4'h4}; #40; passTest({Zero, BusW}, 65'h0FE1896, "LSR1", passed);
		{BusA, BusB, ALUCtrl} = {64'h82C639269A, 64'hA, 4'h4}; #40; passTest({Zero, BusW}, 65'h020B18E49, "LSR2", passed);
		{BusA, BusB, ALUCtrl} = {64'hFA49D367EB2, 64'h4, 4'h4}; #40; passTest({Zero, BusW}, 65'h0FA49D367EB, "LSR3", passed);
		allPassed(passed, 22);
	end
      
endmodule

