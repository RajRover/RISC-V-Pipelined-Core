`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2026 07:05:36 PM
// Design Name: 
// Module Name: Register_File
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

module Register_File(
    input clk,
    input rst,
    input WE3,
    input [4:0] A1,A2,A3,
    input [31:0] WD3,
    output [31:0] RD1,RD2
);

reg [31:0] Register [31:0];
integer i;

always @(posedge clk)
begin
    if(!rst)
    begin
        for(i=0;i<32;i=i+1)
            Register[i] <= 32'b0;
    end
    else if(WE3 && A3 != 5'b00000)
    begin
        Register[A3] <= WD3;
    end
end

assign RD1 = (A1==0)?32'b0:Register[A1];
assign RD2 = (A2==0)?32'b0:Register[A2];

endmodule
