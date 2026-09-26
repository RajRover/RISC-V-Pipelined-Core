# AMBA APB UART (8-N-1) — Design & Verification

A synthesizable UART peripheral with an AMBA APB3 slave interface, designed using RTL and verified using SystemVerilog, SystemVerilog Assertions (SVA), and functional coverage.

## Overview

This project implements a UART peripheral controlled through an AMBA APB3 interface. The APB interface provides memory-mapped access to UART control, status, transmit, and receive registers.

### Key Features

- AMBA APB3 slave interface
- UART transmitter and receiver
- 8-bit data
- No parity
- 1 stop bit
- 8-N-1 UART configuration
- Baud-rate generation
- Memory-mapped control and status registers
- Synthesizable RTL
- SystemVerilog verification
- SystemVerilog Assertions (SVA)
- Functional coverage
- Simulation waveform analysis

## Architecture

```text
                 APB BUS
                    |
                    v
          +-------------------+
          |   APB Interface   |
          |  SETUP / ACCESS   |
          +---------+---------+
                    |
                    v
          +-------------------+
          |   UART Registers  |
          |                   |
          | Control           |
          | Status            |
          | TX Data           |
          | RX Data           |
          | Baud Control      |
          +---------+---------+
                    |
             +------+------+
             |             |
             v             v
      +-------------+ +-------------+
      | UART TX     | | UART RX     |
      | Transmitter | | Receiver    |
      +------+------+ +------+------+
             |               |
            TX              RX
