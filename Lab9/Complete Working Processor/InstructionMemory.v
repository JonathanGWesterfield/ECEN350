`timescale 1ns / 1ps
/*
 * Module: InstructionMemory
 *
 * Implements read-only instruction memory
 * 
 */
module InstructionMemory(Data, Address);
   parameter T_rd = 20;
   parameter MemSize = 40;
   
   output [31:0] Data;
   input [63:0]  Address;
   reg [31:0] 	 Data;
   
   /*
    * ECEN 350 Processor Test Functions
    * Texas A&M University
    */
   
   always @ (Address) begin
      case(Address)

	/* Test Program 1:
	 * Program loads constants from the data memory. Uses these constants to test
	 * the following instructions: LDUR, ORR, AND, CBZ, ADD, SUB, STUR and B.
	 * 
	 * Assembly code for test:
	 * 
	 * 0: LDUR X9, [XZR, 0x0]    //Load 1 into x9
	 * 4: LDUR X10, [XZR, 0x8]   //Load a into x10
	 * 8: LDUR X11, [XZR, 0x10]  //Load 5 into x11
	 * C: LDUR X12, [XZR, 0x18]  //Load big constant into x12
	 * 10: LDUR X13, [XZR, 0x20]  //load a 0 into X13
	 * 
	 * 14: ORR X10, X10, X11  //Create mask of 0xf
	 * 18: AND X12, X12, X10  //Mask off low order bits of big constant
	 * 
	 * loop:
	 * 1C: CBZ X12, end  //while X12 is not 0
	 * 20: ADD X13, X13, X9  //Increment counter in X13
	 * 24: SUB X12, X12, X9  //Decrement remainder of big constant in X12
	 * 28: B loop  //Repeat till X12 is 0
	 * 2C: STUR X13, [XZR, 0x20]  //store back the counter value into the memory location 0x20
	 *
	 *my code
	 
	LDUR X1,[XZR, 0x8]
	ORRI X1, X1, #48
	LSL X1, X1, #2
	STUR X1, [XZR,0x28]
	LDUR X1, [XZR, 0x28]
*/

	63'h000: Data = 32'hF84003E9;
	63'h004: Data = 32'hF84083EA;
	63'h008: Data = 32'hF84103EB;
	63'h00c: Data = 32'hF84183EC;
	63'h010: Data = 32'hF84203ED;
	63'h014: Data = 32'hAA0B014A;
	63'h018: Data = 32'h8A0A018C;
	63'h01c: Data = 32'hB400008C;
	63'h020: Data = 32'h8B0901AD;
	63'h024: Data = 32'hCB09018C;
	63'h028: Data = 32'h17FFFFFD;
	63'h02c: Data = 32'hF80203ED;
	63'h030: Data = 32'hF84203ED;  //One last load to place stored value on memdbus for test checking.

			
	/* Add code for your tests here */
	/*
	63'h034: Data = 32'h8b1f03e1;
	63'h038: Data = 32'hb2000821;
	63'h03C: Data = 32'hd37f0821;
	63'h040: Data = 32'hf80203e1;
	63'h044: Data = 32'hf84203e1;
	*/
	
	/* My Code
	LDUR X1,[XZR, 0x8]
	ORRI X1, X1, #48
	LSL X1, X1, #2
	STUR X1, [XZR,0x28]
	LDUR X1, [XZR, 0x28]	*/


/*	63'h048: Data = 32'hF84083E1;
	63'h04C: Data = 32'hB200C021;
	63'h050: Data = 32'hD37F0821;
	63'h054: Data = 32'hF80283E1;
	63'h058 : Data = 32'hF84283E1;*/
	//64'h04C: Data = {11'b11010011011, 5'b, 6'b0000000, 5'b01001};
	64'h048: Data = {10'b1011001000, 12'b000100100011, 5'b11111, 5'b01001};//123
	64'h04C: Data = {11'b11010011011, 5'b00000, 6'b001100, 5'b01001, 5'b01001}; // lsl
	64'h050: Data = {10'b1011001000, 12'b010001010110, 5'b01001, 5'b01001};//456
	64'h054: Data = {11'b11010011011, 5'b00000, 6'b001100, 5'b01001, 5'b01001}; // lsl
	64'h058: Data = {10'b1011001000, 12'b011110001001, 5'b01001, 5'b01001};//789
	64'h05C: Data = {11'b11010011011, 5'b00000, 6'b001100, 5'b01001, 5'b01001}; // lsl
	64'h060: Data = {10'b1011001000, 12'b101010111100, 5'b01001, 5'b01001};//abc
	64'h064: Data = {11'b11010011011, 5'b00000, 6'b001100, 5'b01001, 5'b01001}; // lsl
	64'h068: Data = {10'b1011001000, 12'b110111101111, 5'b01001, 5'b01001};//def
	64'h06C: Data = {11'b11010011011, 5'b00000, 6'b000100, 5'b01001, 5'b01001};
	63'h070: Data = 32'hF80283E9;
	63'h074 : Data = 32'hF84283E9;
	


	default: Data = 32'hXXXXXXXX;
      endcase
   end
endmodule
