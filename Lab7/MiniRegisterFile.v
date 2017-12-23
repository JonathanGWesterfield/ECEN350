`timescale 1ns/ 1ps

module MiniRegisterFile(BusA, BusB, BusW, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW; // input registers ADD RW, RA, RB

    input RegWr;
    input Clk;
    reg [31:0] registers [31:0];
     
    assign #2 BusA = registers[0];
    assign #2 BusB = registers[1];
     
    always @ (negedge Clk) begin
        if(RegWr)
            registers[RW] <= #3 BusW;
        if(RW == 31)
            registers[RW] <= #3 0;

    end
endmodule
