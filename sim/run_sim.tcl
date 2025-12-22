# ============================================================
# Vivado TCL Script for Behavioral Simulation
# Project: Ring Oscillator Thermal Monitor with UART
# ============================================================

# Reset simulation (if already running)
restart

# Add all signals to waveform
add_wave -r /*

# Run simulation for sufficient time
# (adjust if needed)
run 5 ms

# Stop simulation
stop
