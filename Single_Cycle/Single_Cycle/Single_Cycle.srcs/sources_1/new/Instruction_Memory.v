`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 06:50:55 PM
// Design Name: 
// Module Name: Instruction_Memory
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

module Instruction_Memory(
    input rst,
    input [31:0] A,
    output [31:0] RD
);

reg [31:0] mem [0:1023];

assign RD = (~rst) ? 32'b0 : mem[A[11:2]];

initial begin
    $readmemh("memfile.mem", mem);
end

endmodule
