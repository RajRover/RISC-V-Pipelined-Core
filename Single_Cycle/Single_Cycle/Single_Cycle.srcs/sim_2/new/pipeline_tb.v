`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 03:39:50 PM
// Design Name: 
// Module Name: pipeline_tb
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


module pipeline_tb;

    // Inputs
    reg clk;
    reg rst;

    // Instantiate DUT
    Pipeline_top uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 0;

        // Apply reset
        #10;
        rst = 1;

        // Run simulation
        #300;

        $finish;
    end

    // -------------------------------
    // MONITOR (important signals)
    // -------------------------------
    initial begin
        $monitor("T=%0t | PC=%h | Instr=%h | ALU=%h | WD=%h | RD=%d | RegWrite=%b",
                  $time,
                  uut.Fetch.PCD,
                  uut.Fetch.InstrD,
                  uut.Execute.ALU_ResultM,
                  uut.Memory.WriteDataM,
                  uut.Memory.RD_W,
                  uut.Memory.RegWriteW
        );
    end

endmodule
