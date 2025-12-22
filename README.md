# FPGA-Based Thermal Monitoring Using Ring Oscillator

## Overview
This project implements a simple FPGA-based thermal monitoring system using a ring oscillator (RO).  
The oscillation frequency of the RO varies with temperature, enabling indirect thermal sensing without dedicated temperature sensors.

The RO frequency is measured using digital logic and the data is transmitted to a host PC through UART for observation and analysis.

## Objectives
- Implement a ring oscillator as a temperature-sensitive element
- Measure RO frequency using counters and time windows
- Transmit measured data using UART

## Module Description
- ring_oscillator.v : Generates temperature-dependent oscillation
- FF2.v : Synchronizes RO signal to system clock
- edge_detector.v : Detects transitions of RO signal
- edge_counter.v : Counts RO edges
- window.v : Defines fixed measurement interval
- latch_register.v : Captures count value at window end
- UART.v : Transmits data serially to PC
- top_therm.v : Top-level module integrating all blocks
- tb_therm.v : Testbench for simulation

## Key Concepts Used
- Ring oscillator based thermal sensing
- Asynchronous to synchronous signal crossing
- Time-windowed frequency measurement
- UART serial communication
- Sticky-flag handshaking for reliable control

## Simulation
The design is verified using behavioral simulation.  
UART transmission, windowing, and counter operation are validated through waveform analysis.

## Future Improvements
- Calibrate RO count to actual temperature values
- Add PC-side software for data logging and plotting
- Use multiple ring oscillators for spatial thermal mapping
- Implement thermal-aware control or throttling mechanisms
- Extend system for security and anomaly detection

## Tools Used
- Verilog HDL
- FPGA simulation tools
- UART communication

## Author
Sam Daniel A
B.Tech Electronics Engineering  
College of Engineering, Guindy – Anna University
