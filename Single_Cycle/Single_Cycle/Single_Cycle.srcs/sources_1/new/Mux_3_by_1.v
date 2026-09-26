`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 01:22:57 PM
// Design Name: 
// Module Name: Mux_3_by_1
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


module Mux_3_by_1 (
    input [31:0] a,  // from register
    input [31:0] b,  // from writeback
    input [31:0] c,  // from memory stage
    input [1:0] s,   // select
    output reg [31:0] d
);

always @(*) begin
    case (s)
        2'b00: d = a; // normal
        2'b01: d = b; // forward from WB
        2'b10: d = c; // forward from MEM
        default: d = a;
    endcase
end

endmodule
