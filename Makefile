IVERILOG = iverilog
IVERILOG_FLAGS = -g2012

SRC_DIR = src
TB_LAYERED_DIR = tb/layered
TB_SIMPLE_DIR = tb/simple
SIM_OUTPUT_DIR = sim/output

SRC_FILES = $(SRC_DIR)/design.sv
TB_LAYERED_FILES = $(wildcard $(TB_LAYERED_DIR)/*.sv)
TB_SIMPLE_FILES = $(TB_SIMPLE_DIR)/testbench_simple.sv

all: layered simple

layered: $(SRC_FILES) $(TB_LAYERED_FILES)
	@mkdir -p $(SIM_OUTPUT_DIR)
	$(IVERILOG) $(IVERILOG_FLAGS) -I$(SRC_DIR) -I$(TB_LAYERED_DIR) \
		$(SRC_FILES) $(TB_LAYERED_FILES) -o $(SIM_OUTPUT_DIR)/layered.out

simple: $(SRC_FILES) $(TB_SIMPLE_FILES)
	@mkdir -p $(SIM_OUTPUT_DIR)
	$(IVERILOG) $(IVERILOG_FLAGS) -I$(SRC_DIR) -I$(TB_SIMPLE_DIR) \
		$(SRC_FILES) $(TB_SIMPLE_FILES) -o $(SIM_OUTPUT_DIR)/simple.out

run_layered: layered
	./$(SIM_OUTPUT_DIR)/layered.out
	@mv *.vcd $(SIM_OUTPUT_DIR)/

run_simple: simple
	./$(SIM_OUTPUT_DIR)/simple.out
	@mv *.vcd $(SIM_OUTPUT_DIR)/

clean:
	rm -rf $(SIM_OUTPUT_DIR)/*

.PHONY: all layered simple run_layered run_simple clean
