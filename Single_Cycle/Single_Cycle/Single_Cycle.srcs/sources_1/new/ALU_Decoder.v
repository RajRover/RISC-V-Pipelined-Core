`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 06:43:37 PM
// Design Name: 
// Module Name: ALU_Decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_Decoder(ALUOp,funct3,funct7,op,ALUControl);

input [1:0] ALUOp;
input [2:0] funct3;
input [6:0] funct7,op;
output [2:0] ALUControl;

assign ALUControl =
    (ALUOp == 2'b00) ? 3'b000 :                          // add
    (ALUOp == 2'b01) ? 3'b001 :                          // sub
    (ALUOp == 2'b10 && funct3 == 3'b000) ? (funct7[5] ? 3'b001 : 3'b000) :
    (ALUOp == 2'b10 && funct3 == 3'b111) ? 3'b010 :
    (ALUOp == 2'b10 && funct3 == 3'b110) ? 3'b011 :
    (ALUOp == 2'b10 && funct3 == 3'b100) ? 3'b100 :
    (ALUOp == 2'b10 && funct3 == 3'b010) ? 3'b101 :
                                           3'b000;

endmodule