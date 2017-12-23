
`timescale 1ns / 1ps

module SignExtender(BusImm, Imm32);
  output reg [63:0] BusImm;
  input [31:0] Imm32;
  
  
  reg extBit;
  

  reg [32:0] test ;

  always @( Imm32 )
     begin
    test = Imm32 ;
    //Branch
    if (test [31:26] == 6'b000101|| test [31:26] == 6'b100101)
           begin
      extBit = test[25];
      BusImm = {{38{ extBit}},test[25:0]};
        end
    //Conditional Branch
     else if (test[31:24] ==8'b01010100||test[31:24]== 8'b10110100||test[31:24]== 8'b10110101 ) 
        begin
      extBit = test[23];
      BusImm = {{45{ extBit}},test[23:5]}; 
        end
    //D type instruction
     else if (test[31:21] == 11'b11111000000|| 
       test[31:21] == 11'b11111000010||
      test[31:21] ==11'b00111000010 ||
      test[31:21]==11'b00111000000 ||
      test[31:21]==11'b01111000000 ||
      test[31:21]==11'b01111000010 ||
      test[31:21]==11'b10111000000 ||
      test[31:21]==11'b10111000100 ||
      test[31:21]==11'b11001000000 ||
      test[31:21]==11'b11001000010 )
        begin
      extBit = test[20];
      BusImm = {{55{ extBit}},test[20:12]}; 
        end
      //ORRI opcode for sign extension
    else if (test[31:22] == 10'b1011001000 ) begin
        extBit = test[21];
      	BusImm = {{52'b0},test[21:10]}; 
    end
    //LSL opcode
    else if (test[31:21] == 11'b11010011011)begin
    	extBit = test[15];
    	BusImm = {{58{ extBit}},test[15:10]}; 
    end

	else 
   	begin
   		BusImm = 64'b0 ;
    end
end
    
      
endmodule
