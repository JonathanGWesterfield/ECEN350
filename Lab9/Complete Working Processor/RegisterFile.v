`timescale 1ns/ 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW; // input registers ADD RW, RA, RB

    input RegWr;
    input Clk;
    reg [63:0] registers [31:0];

    /* this is the correct way
    wire [63:0] register31;
    assign register31 = 0;
    */

    
    assign #2 BusA = registers[RA]; // X5
    assign #2 BusB = registers[RB]; // X6

    // sets all of the register values to 0
    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            registers[i] <= 0;
        end
    end
     
    
     
    always @ (negedge Clk) begin
        registers[31]<= #3 0;
        
        if(RegWr)
        begin
            if (RW != 31)
            begin
                registers[RW]<= #3 BusW;
            end
        end
    end
endmodule
