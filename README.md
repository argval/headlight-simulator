# Car Headlight Simulator

A SystemVerilog implementation of a car headlight control system that simulates turn signals and hazard lights. The project includes both a layered testbench architecture and a simplified testbench for verification.

## Features

- Left turn signal simulation
- Right turn signal simulation
- Hazard lights simulation
- Sequential light patterns
- Reset functionality
- Comprehensive test scenarios

## Design Architecture

### Core Components

1. **Design Module (`src/design.sv`)**
   - Main state machine implementation
   - Handles turn signals and hazard patterns
   - 3-bit output for each side (li[2:0], ri[2:0])
   - Supports reset functionality

2. **Layered Testbench (`tb/layered/`)**
   - Interface (`interface.sv`): Signal definitions and modports
   - Transaction Class (`transaction.sv`): Stimulus generation
   - Generator (`generator.sv`): Test pattern generation
   - Driver (`driver.sv`): DUT signal driving
   - Monitor (`monitor.sv`): Output collection
   - Scoreboard (`scoreboard.sv`): Result verification
   - Environment (`environment.sv`): Test environment setup
   - Top-level testbench (`tb_top.sv`): Main testbench file

3. **Simple Testbench (`tb/simple/`)**
   - Basic functionality verification
   - Comprehensive test scenarios
   - Waveform generation

## Signal Patterns

### Turn Signals
- Left Turn: 100 -> 110 -> 111 -> 111 -> 100
- Right Turn: 001 -> 011 -> 111 -> 111 -> 001

### Hazard Lights
Both left and right indicators follow synchronized patterns:
```
Left:  000 -> 100 -> 110 -> 111 -> 110 -> 100 -> 000
Right: 000 -> 001 -> 011 -> 111 -> 011 -> 001 -> 000
```

## Getting Started

### Prerequisites
- Icarus Verilog (iverilog)
- GTKWave (optional, for viewing waveforms)
- WaveTrace (optional, if you're on VSCode, you can install this extension to view the waveforms instead of downloading GTKWave)

### Installation
```bash
# Install Icarus Verilog
brew install icarus-verilog

# Install GTKWave (optional)
brew install gtkwave
```

### Running the Simulation

You can use either make commands or the run script:

#### Using Make
```bash
# Run layered testbench
make run_layered

# Run simple testbench
make run_simple

# Clean simulation outputs
make clean
```

#### Using Run Script
```bash
# Run the simulation
./sim/scripts/run.sh
```

## Test Scenarios

The testbench verifies the following scenarios:
1. Basic left turn signal operation
2. Basic right turn signal operation
3. Hazard lights operation
4. Reset during operation
5. Signal transitions and timing
6. Multiple mode switches

## Waveform Analysis

The simulation generates a VCD file in the `sim/output` directory that can be viewed using GTKWave. Key signals to observe:
- clk: System clock
- rst: Reset signal
- lt: Left turn signal input
- rt: Right turn signal input
- haz: Hazard signal input
- li[2:0]: Left indicator output
- ri[2:0]: Right indicator output

## Project Structure
```
headlight-simulator/
├── src/                    # Design source files
│   └── design.sv           # Main design file
├── tb/                     # Testbench files
│   ├── layered/           # Layered testbench components
│   │   ├── interface.sv
│   │   ├── transaction.sv
│   │   ├── generator.sv
│   │   ├── driver.sv
│   │   ├── monitor.sv
│   │   ├── scoreboard.sv
│   │   ├── environment.sv
│   │   ├── test.sv
│   │   └── tb_top.sv
│   └── simple/            # Simple testbench
│       └── testbench_simple.sv
├── sim/                   # Simulation files
│   ├── scripts/          # Simulation scripts
│   │   └── run.sh
│   └── output/           # Simulation outputs
├── Makefile              # Build system
└── README.md             # This file
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Authors

- Anurag Vallur
