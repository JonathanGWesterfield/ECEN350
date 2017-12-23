`timescale 1ns/ 1ps

module SignExtender(BusImm, Imm32);

	input [31:0] Imm32;
	output reg [63:0] BusImm;

	always @(*)
	begin
	if(Imm32[31:26] == 6'b000101 || Imm32[31:26] == 6'b100101)
	begin
		BusImm = {{38{Imm32[25]}}, Imm32[25:0]}; 
	end

	else if(Imm32[31:24] == 8'b01010100 || 
		Imm32[31:24] == 8'b10110100 || 
		Imm32[31:24] == 8'b10110101) // CB type
		begin
		BusImm = {{45{Imm32[23]}}, Imm32[23:5]};
		end

	else if(Imm32[31:21] == 11'b00111000000 || //D type
		Imm32[31:21] == 11'b01111000010 || 
		Imm32[31:21] == 11'b01111000000 ||
		Imm32[31:21] == 11'b01111000010 ||
		Imm32[31:21] == 11'b10111000000 || 
		Imm32[31:21] == 11'b10111000100 ||
		Imm32[31:21] == 11'b11001000000 || 
		Imm32[31:21] == 11'b11001000010 ||
		Imm32[31:21] == 11'b11111000000 || 
		Imm32[31:21] == 11'b11111000010)
	begin
		BusImm = {{55{Imm32[20]}}, Imm32[20:12]};
	end
	else
	begin 
		BusImm = 64'b0;
	end
		
	end
endmodule
