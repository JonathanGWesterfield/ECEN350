`timescale 1ns / 1ps


`define STRLEN 48
`define HALFCLKPERIOD 6
module RegisterFileTest_v;


	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%0t - %s failed: 0x%H should be 0x%H",$time, testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusW;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW;
	reg RegWr;
	reg Clk;
	reg [7:0] passed;
	reg [7:0] numTests;
	// Outputs
	wire [63:0] BusA;
	wire [63:0] BusB;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut (
		.BusA(BusA), 
		.BusB(BusB), 
		.BusW(BusW), 
		.RA(RA), 
		.RB(RB), 
		.RW(RW), 
		.RegWr(RegWr), 
		.Clk(Clk)
	);

	initial begin
		// Initialize Inputs
		BusW = 0;
		RA = 0;
		RB = 0;
		RW = 0;
		RegWr = 0;
		Clk = 1;
		passed = 0;
		numTests = 0;
		#`HALFCLKPERIOD;

		/* Run tests to make sure that X31 is 0 and stays 0 */
		{RA, RB, RW, BusW, RegWr} = {5'd31, 5'd31, 5'd31, 64'h0, 1'b0};
		#`HALFCLKPERIOD
		passTest(BusA, 64'h0, "Initial $0 Check 1", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h0, "Initial $0 Check 2", passed);
		numTests = numTests + 1;
		#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		
		{RA, RB, RW, BusW, RegWr} = {5'd31, 5'd31, 5'd31, 64'h12345678, 1'b1};
		passTest(BusA, 64'h0, "Initial $0 Check 3", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h0, "Initial $0 Check 4", passed);
		numTests = numTests + 1;
		#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		passTest(BusA, 64'h0, "$0 Stays 0 Check 1", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h0, "$0 Stays 0 Check 2", passed);
		numTests = numTests + 1;
		
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 64'h0, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd1, 64'h1, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd2, 64'h2, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd3, 64'h3, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd4, 64'h4, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd5, 64'h5, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd6, 64'h6, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd7, 64'h7, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd8, 64'h8, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd9, 64'h9, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd10, 64'hA, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd11, 64'hB, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd12, 64'hC, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd13, 64'hD, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd14, 64'hE, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd15, 64'hF, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd16, 64'h10, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd17, 64'h11, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd18, 64'h12, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd19, 64'h13, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd20, 64'h14, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd21, 64'h15, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd22, 64'h16, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd23, 64'h17, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd24, 64'h18, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd25, 64'h19, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd26, 64'h1A, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd27, 64'h1B, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd28, 64'h1C, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd29, 64'h1D, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd30, 64'h1E, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd31, 64'h1F, 1'b1};#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD; Clk = 1;

		#`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd1, 5'd0, 64'h0, 1'b0};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'h0, "A Reading X0", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h1, "B Reading X1", passed);
		numTests = numTests + 1;

		{RA, RB, RW, RegWr, BusW} ={5'd2, 5'd3, 5'd1, 1'b0, 64'h1000};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'h2, "A Reading X2", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h3, "B Reading X3", passed);
		numTests = numTests + 1;
		
		{RA, RB, RW, RegWr, BusW} ={5'd4, 5'd5, 5'd0, 1'b1, 64'h1000};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'h4, "Write X0 = 0x1000, A Reading X4", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h5, "Write X0 = 0x1000, B Reading X5", passed);
		numTests = numTests + 1;
		
		{RA, RB, RW, RegWr, BusW} ={5'd4, 5'd5, 5'd0, 1'b1, 64'h1000};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'h4, "Write X0 = 0x1000, A Reading X4", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h5, "Write X0 = 0x1000, B Reading X5", passed);
		numTests = numTests + 1;
		
		{RA, RB, RW, RegWr, BusW} ={5'd6, 5'd7, 5'ha, 1'b1, 64'h1010};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'h6, "Write XA = 0x1010, A Reading X6", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h7, "Write XA = 0x1010, B Reading X7", passed);
		numTests = numTests + 1;

		{RA, RB, RW, RegWr, BusW} ={5'd8, 5'd9, 5'hb, 1'b1, 64'h103000};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'h8, "Write XB = 0x103000, A Reading X8", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h9, "Write XB = 0x103000, B Reading X9", passed);
		numTests = numTests + 1;
		
		{RA, RB, RW, RegWr, BusW} ={5'hA, 5'hB, 5'hC, 1'b0, 64'h0};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'h1010, "A Reading XA", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'h103000, "B Reading XB", passed);
		numTests = numTests + 1;
		
		{RA, RB, RW, RegWr, BusW} ={5'hC, 5'hD, 5'hD, 1'b1, 64'hABCD};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'hC, "Write XD = 0xABCD, A Reading XC", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'hABCD, "Write XD = 0xABCD, B Reading XD", passed);
		numTests = numTests + 1;
		
		{RA, RB, RW, RegWr, BusW} ={5'hE, 5'hF, 5'hE, 1'b0, 64'h9080009};
		Clk = 1; #`HALFCLKPERIOD; Clk = 0; #`HALFCLKPERIOD;
		passTest(BusA, 64'hE, "A Reading XE", passed);
		numTests = numTests + 1;
		passTest(BusB, 64'hF, "B Reading XF", passed);
		numTests = numTests + 1;
		
		allPassed(passed, numTests);
	end
      
endmodule
