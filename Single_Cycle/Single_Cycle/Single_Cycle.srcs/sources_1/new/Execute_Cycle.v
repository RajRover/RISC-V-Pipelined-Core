`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2026 01:15:20 PM
// Design Name: 
// Module Name: Execute_Cycle
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


module Execute_Cycle(
    input clk, rst,

    // Control signals
    input RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,
    input [2:0] ALUControlE,

    // Data signals
    input [31:0] RD1_E, RD2_E, Imm_Ext_E,
    input [4:0] RD_E,
    input [31:0] PCE, PCPlus4E,

    // Forwarding inputs (keep 2'b00 for now)
    input [31:0] ResultW,
    input [1:0] ForwardA_E, ForwardB_E,

    // Outputs
    output PCSrcE,
    output RegWriteM, MemWriteM, ResultSrcM,
    output [4:0] RD_M,
    output [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
    output [31:0] PCTargetE
);

    // Internal wires
    wire [31:0] Src_A, Src_B_interim, Src_B;
    wire [31:0] ResultE;
    wire ZeroE;

    // Pipeline registers
    reg RegWriteE_r, MemWriteE_r, ResultSrcE_r;
    reg [4:0] RD_E_r;
    reg [31:0] PCPlus4E_r, RD2_E_r, ResultE_r;

    // -----------------------------
    // Forwarding Mux (Src A)
    // -----------------------------
    Mux_3_by_1 srca_mux (
        .a(RD1_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardA_E),
        .d(Src_A)
    );

    // -----------------------------
    // Forwarding Mux (Src B)
    // -----------------------------
    Mux_3_by_1 srcb_mux (
        .a(RD2_E),
        .b(ResultW),
        .c(ALU_ResultM),
        .s(ForwardB_E),
        .d(Src_B_interim)
    );

    // -----------------------------
    // ALU Source Mux
    // -----------------------------
    Mux alu_src_mux (
        .a(Src_B_interim),
        .b(Imm_Ext_E),
        .s(ALUSrcE),
        .c(Src_B)
    );

    // -----------------------------
    // ALU
    // -----------------------------
    ALU alu (
        .A(Src_A),
        .B(Src_B),
        .Result(ResultE),
        .ALUControl(ALUControlE),
        .OverFlow(),
        .Carry(),
        .Zero(ZeroE),
        .Negative()
    );

    // -----------------------------
    // Branch Target Calculation (FIXED)
    // -----------------------------
    PC_Adder branch_adder (
        .a(PCE),
        .b(Imm_Ext_E),   // 🔥 IMPORTANT FIX
        .c(PCTargetE)
    );

    // -----------------------------
    // Pipeline Register (E → M)
    // -----------------------------
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            RegWriteE_r <= 0;
            MemWriteE_r <= 0;
            ResultSrcE_r <= 0;
            RD_E_r <= 0;
            PCPlus4E_r <= 0;
            RD2_E_r <= 0;
            ResultE_r <= 0;
        end else begin
            RegWriteE_r <= RegWriteE;
            MemWriteE_r <= MemWriteE;
            ResultSrcE_r <= ResultSrcE;
            RD_E_r <= RD_E;
            PCPlus4E_r <= PCPlus4E;

            // store data path (correct source)
            RD2_E_r <= Src_B_interim;

            // ALU result
            ResultE_r <= ResultE;
        end
    end

    // -----------------------------
    // Outputs
    // -----------------------------
    assign PCSrcE      = ZeroE & BranchE;
    assign RegWriteM   = RegWriteE_r;
    assign MemWriteM   = MemWriteE_r;
    assign ResultSrcM  = ResultSrcE_r;
    assign RD_M        = RD_E_r;
    assign PCPlus4M    = PCPlus4E_r;
    assign WriteDataM  = RD2_E_r;
    assign ALU_ResultM = ResultE_r;

endmodule
