`timescale 1ns / 1ps

module ALUControl(ALUCtrl, ALUop, Opcode);

     input [10:0] Opcode; // 11 bit input
     input [1:0] ALUop; // 2 bit input 
     output reg [3:0] ALUCtrl; // the output to the ALU
     
     always @(*) begin
     	if(ALUop == 2'b00) begin // for LDUR and STUR
     		ALUCtrl <= #2 4'b0010; // add code
     	end
     	else if(ALUop == 2'b01) begin // CBZ instruction
     		ALUCtrl <= #2 4'b0111; // passB code
     	end
     	else if(ALUop == 2'b10) begin
               if(Opcode == 11'b10110010000 || Opcode == 11'b10110010001) begin // ORRI 
                    ALUCtrl <= #2 4'b0001; // Left shift control
               end 
     		else if(Opcode == 11'b10001011000) begin // ADD 
     			ALUCtrl <= #2 4'b0010; // add ctrl
     		end
     		else if(Opcode == 11'b11001011000) begin // SUB 
     			ALUCtrl <= #2 4'b0110; // subtract ctrl
     		end
     		else if(Opcode == 11'b10001010000) begin // AND
     			ALUCtrl <= #2 4'b0000; // AND ctrl
     		end
     		else if(Opcode == 11'b10101010000 || Opcode == 10'b1011001000) begin // OR and ORRI
     			ALUCtrl <= #2 4'b0001; // OR ctrl
     		end
               else if(Opcode == 11'b11010011011) begin // LSL
                    ALUCtrl <= #2 4'b0011; // Left shift control
               end
     	end
     end 

endmodule