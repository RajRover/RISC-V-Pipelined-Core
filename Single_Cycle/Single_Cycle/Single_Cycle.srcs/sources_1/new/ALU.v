`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 06:32:51 PM
// Design Name: 
// Module Name: ALU
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

module ALU(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);

    input [31:0] A,B;
    input [2:0] ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [31:0] Result;

    wire Cout;
    wire [31:0] Sum;

    // ADD / SUB
    assign {Cout,Sum} = (ALUControl[0]==0) ? {1'b0,A} + {1'b0,B}
                                           : {1'b0,A} + {1'b0,(~B+1)};

    // ALU Operations
    assign Result = (ALUControl == 3'b000) ? Sum :                 // ADD
                    (ALUControl == 3'b001) ? Sum :                 // SUB
                    (ALUControl == 3'b010) ? (A & B) :             // AND
                    (ALUControl == 3'b011) ? (A | B) :             // OR
                    (ALUControl == 3'b100) ? (A ^ B) :             // XOR
                    (ALUControl == 3'b101) ? {{31{1'b0}},Sum[31]}: // SLT
                                             32'b0;

    // Flags
    assign OverFlow = ((Sum[31] ^ A[31]) &
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));

    assign Carry = ((~ALUControl[1]) & Cout);

    assign Zero = (Result == 32'b0);

    assign Negative = Result[31];

endmodule
