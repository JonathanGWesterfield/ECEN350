`timescale 1ns / 1ps

module DataMemory(ReadData, Address, WriteData,
                  MemoryRead, MemoryWrite, Clock);
     input [63:0] Address, WriteData;
     input MemoryRead, MemoryWrite, Clock;
     output reg [63:0] ReadData;
     
     reg [63:0] memory [63:0]; //64 bit memory array of size 64

     always @(posedge Clock) begin 
     	if(MemoryRead) begin
     		if(!MemoryWrite) begin
     			ReadData <= #20 memory[Address];
     		end
     	end
     end

     always @(negedge Clock) begin 
     	if(MemoryWrite) begin // allows us to write to the memory
     		if(!MemoryRead) begin // memRead must be 0
     			memory[Address] <= #20 WriteData;
     		end
     	end 
     end

endmodule