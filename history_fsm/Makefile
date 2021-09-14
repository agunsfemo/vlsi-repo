# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)

history_fsm:
	rm -rf bin/
	mkdir bin
	iverilog -o bin/history_fsm.vvp -s history_fsm -s dump -g2012 src/history_fsm.sv utils/dump_history_fsm.sv
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test_history_fsm vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus  bin/history_fsm.vvp
	! grep failure results.xml

show_graph:
	gtkwave history_fsm.vcd

synth:
	yosys -p "read_verilog -sv src/history_fsm.sv; proc; opt; show -colors 2 -width -signed"

clean:
	rm -rf bin/
	rm -rf *.vcd
	rm -rf *.xml
	rm -rf __pycache__

.PHONY: clean

	
