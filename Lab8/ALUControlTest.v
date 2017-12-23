
module ALUControlTest ;

task passTest;
		input [3:0] outputControl, expectedControl;
	
		if(outputControl == expectedControl) begin 
			$display ("Passed");
		end
		else 
			$display ("Failed: %d should be %d", outputControl, expectedControl);

	endtask

//inputs are registers
//outputs are wires

////inputs
reg [1:0] ALUop;
reg [10:0] Opcode;

//outputs
wire [3:0] outputControl;

ALUControl uut(.ALUCtrl(outputControl), .ALUop(ALUop), .Opcode(Opcode));

initial begin
	ALUop = 0;
	Opcode = 0;

	$display ("Begin Testing the ALU Control");

	ALUop = 2'b00; Opcode = 11'b???????????; // 1 LDUR 
	#2
	#50 passTest(outputControl, 4'b0010);

	ALUop = 2'b01; Opcode = 11'b???????????; // 2 CBZ
	#2 
	#50 passTest(outputControl, 4'b0111);

	ALUop = 2'b10; Opcode = 11'b11001011000; // 3 R-type SUB
	#2 
	#50 passTest(outputControl, 4'b0110);

	ALUop = 2'b10; Opcode = 11'b10101010000; // 4 R-Type ORR
	#2 
	#50 passTest(outputControl, 4'b0001);

	ALUop = 2'b10; Opcode = 11'b10001010000; // 5 R-Type AND
	#2 
	#50 passTest(outputControl, 4'b0000);

	ALUop = 2'b10; Opcode = 11'b10001011000; // 6 R-Type ADD 
	#2 
	#50 passTest(outputControl, 4'b0010);

	ALUop = 2'b10; Opcode = 11'b10101010000; // 7 R-Type AND
	#2 
	#50 passTest(outputControl, 4'b0001);

	ALUop = 2'b10; Opcode = 11'b 10001011000; // 8 R-Type ADD
	#2 
	#50 passTest(outputControl, 4'b0010);

	ALUop = 2'b10; Opcode = 11'b11001011000; // 9 R-Type SUB
	#2 
	#50 passTest(outputControl, 4'b0110);

end

endmodule // ALUControlTest