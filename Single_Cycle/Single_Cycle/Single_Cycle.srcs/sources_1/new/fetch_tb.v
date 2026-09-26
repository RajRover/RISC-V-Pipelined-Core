`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 12:23:27 PM
// Design Name: 
// Module Name: fetch_tb
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


`timescale 1ns/1ps

module fetch_tb;

    // Inputs
    reg clk;
    reg rst;
    reg PCSrcE;
    reg [31:0] PCTargetE;

    // Outputs
    wire [31:0] InstrD;
    wire [31:0] PCD;
    wire [31:0] PCPlus4D;

    // Instantiate DUT
    fetch_cycle uut (
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 0;
        PCSrcE = 0;
        PCTargetE = 32'h00000000;

        // Apply reset
        #10;
        rst = 1;

        // ----------------------------
        // Normal sequential execution
        // ----------------------------
        #40;

        // ----------------------------
        // Branch NOT taken
        // ----------------------------
        PCSrcE = 0;
        #20;

        // ----------------------------
        // Branch TAKEN
        // ----------------------------
        PCSrcE = 1;
        PCTargetE = 32'h00000020;   // Jump to address 32
        #10;

        PCSrcE = 0; // back to normal
        #40;

        // ----------------------------
        // Another branch TAKEN
        // ----------------------------
        PCSrcE = 1;
        PCTargetE = 32'h00000040;   // Jump to address 64
        #10;

        PCSrcE = 0;
        #40;

        // Finish simulation
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | PC=%h | PC+4=%h | Instr=%h | PCSrcE=%b",
                  $time, PCD, PCPlus4D, InstrD, PCSrcE);
    end

endmodule