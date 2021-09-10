# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)

flop_reset:
	rm -rf bin/
	mkdir bin
	iverilog -o bin/flop_reset.vvp -s flop_reset -s dump -g2012 src/flop_reset.sv utils/dump_flop_reset.sv
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test_flop_reset vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus  bin/flop_reset.vvp
	! grep failure results.xml

show_graph:
	gtkwave flop_reset.vcd

synth:
	yosys -p "read_verilog -sv src/flop_reset.sv; proc; opt; show -colors 2 -width -signed"

clean:
	rm -rf bin/
	rm -rf *.vcd
	rm -rf *.xml
	rm -rf __pycache__

.PHONY: clean

	
