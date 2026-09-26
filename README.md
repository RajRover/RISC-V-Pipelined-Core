# RISC-V 5-Stage Pipelined Processor

A 32-bit RISC-V processor designed from scratch using **Verilog HDL**, progressing from a single-cycle architecture to a **5-stage pipelined CPU**. The project focuses on RTL design, computer architecture, pipeline operation, and hazard handling.

## Overview

This project implements a RISC-V processor based on the **RV32I instruction set architecture**.

The processor follows the classic 5-stage pipeline:

```text
IF → ID → EX → MEM → WB
