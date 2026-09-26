`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 06:49:04 PM
// Design Name: 
// Module Name: Data_Memory
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

module Data_Memory(
    input clk,
    input rst,
    input WE,                 // Write enable
    input [31:0] A,           // Address
    input [31:0] WD,          // Write data
    output [31:0] RD          // Read data
);

reg [31:0] mem [0:1023];
integer i;

always @(posedge clk)
begin
    if(!rst)
    begin
        for(i=0;i<1024;i=i+1)
            mem[i] <= 32'b0;
    end
    else if(WE)
    begin
        mem[A[11:2]] <= WD;   // word aligned access
    end
end

assign RD = mem[A[11:2]];

endmodule