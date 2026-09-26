`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 06:54:58 PM
// Design Name: 
// Module Name: Main_Decoder
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


module Main_Decoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp);

    input [6:0] Op;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0] ImmSrc,ALUOp;

    // Register Write Enable
    assign RegWrite = (Op == 7'b0000011 ||   // lw
                       Op == 7'b0110011 ||   // R-type
                       Op == 7'b0010011);    // I-type

    // Immediate source selection
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 :   // S-type (sw)
                    (Op == 7'b1100011) ? 2'b10 :   // B-type (branch)
                                         2'b00;    // I-type

    // ALU second operand select
    assign ALUSrc = (Op == 7'b0000011 || 
                     Op == 7'b0100011 || 
                     Op == 7'b0010011);

    // Memory write enable
    assign MemWrite = (Op == 7'b0100011);

    // Writeback source
    assign ResultSrc = (Op == 7'b0000011);   // lw

    // Branch instruction
    assign Branch = (Op == 7'b1100011);

    // ALU operation type
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :   // R-type
                   (Op == 7'b1100011) ? 2'b01 :   // branch
                                        2'b00;    // lw/sw/addi

endmodule