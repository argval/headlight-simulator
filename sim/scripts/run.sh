#!/bin/bash

# Change to project root directory
cd ../..

# Clean up previous runs
rm -rf sim/output/*

# Create output directory if it doesn't exist
mkdir -p sim/output

# Compile the design
# For layered testbench:
iverilog -g2012 \
  -I src \
  -I tb/layered \
  src/design.sv \
  tb/layered/*.sv \
  -o sim/output/layered.out

# For simple testbench:
iverilog -g2012 \
  -I src \
  -I tb/simple \
  src/design.sv \
  tb/simple/testbench_simple.sv \
  -o sim/output/simple.out

# Run the simulation (choose one)
# ./sim/output/layered.out  # For layered testbench
./sim/output/simple.out   # For simple testbench

# Move VCD file to output directory
mv *.vcd sim/output/

# Open the waveform viewer if available
if command -v gtkwave &> /dev/null; then
    gtkwave sim/output/headlight.vcd &
else
    echo "GTKWave not found. Install it to view the waveform."
fi