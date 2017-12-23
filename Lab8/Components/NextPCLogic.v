`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       	input [63:0] CurrentPC, SignExtImm64; 
       	input Branch, ALUZero, Uncondbranch; 
       	output reg [63:0] NextPC; 

       	reg [63:0] tempImm64;

    always @(*) begin

    	tempImm64 = SignExtImm64 << 2; // have to shift the value over by 2

    	// for unconditional branches
       	if(Uncondbranch) begin
       		NextPC  <= #1 CurrentPC + tempImm64; // jumps to that address
       	end
       	else if(Branch) begin // for conditional branches
       		if(ALUZero == 1) begin // it was zero therefore should branch
       			NextPC <= #2 CurrentPC + tempImm64;
       		end
       		else begin
       			NextPC <= #2 CurrentPC + 4; // if evaluates to false
       		end
       	end
       	else begin // branch and Uncondbranch are false
       		NextPC <= #2 CurrentPC + 4;
       	end
   	end

endmodule