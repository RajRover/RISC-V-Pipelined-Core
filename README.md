# RISC-V 5-Stage Pipelined Processor

A 32-bit RISC-V processor designed from scratch using Verilog HDL, progressing from a single-cycle architecture to a 5-stage pipelined CPU. The project focuses on RTL design, computer architecture, pipelining, and processor datapath/control implementation.

## Overview

This project implements a 32-bit RISC-V processor based on the RV32I instruction set architecture.

The processor is organized into five classic pipeline stages:

**IF → ID → EX → MEM → WB**

- **IF (Instruction Fetch):** Fetches instructions using the Program Counter.
- **ID (Instruction Decode):** Decodes instructions and reads operands from the register file.
- **EX (Execute):** Performs arithmetic, logical, comparison, and address-generation operations.
- **MEM (Memory Access):** Performs load and store operations.
- **WB (Write Back):** Writes the execution or memory result back to the register file.

## Architecture

```text
                    ┌─────────────────────┐
                    │  Instruction Memory │
                    └──────────┬──────────┘
                               │
                               ▼
                         ┌───────────┐
                         │    IF     │
                         │ Fetch     │
                         └─────┬─────┘
                               │
                         ┌─────▼─────┐
                         │  IF / ID  │
                         │   Reg     │
                         └─────┬─────┘
                               │
                               ▼
                         ┌───────────┐
                         │    ID     │
                         │ Decode    │
                         │ Register  │
                         │ File      │
                         └─────┬─────┘
                               │
                         ┌─────▼─────┐
                         │  ID / EX  │
                         │   Reg     │
                         └─────┬─────┘
                               │
                               ▼
                         ┌───────────┐
                         │    EX     │
                         │    ALU    │
                         └─────┬─────┘
                               │
                         ┌─────▼─────┐
                         │ EX / MEM  │
                         │   Reg     │
                         └─────┬─────┘
                               │
                               ▼
                         ┌───────────┐
                         │    MEM    │
                         │ Data Mem  │
                         └─────┬─────┘
                               │
                         ┌─────▼─────┐
                         │ MEM / WB  │
                         │   Reg     │
                         └─────┬─────┘
                               │
                               ▼
                         ┌───────────┐
                         │    WB     │
                         │ Writeback │
                         └───────────┘
