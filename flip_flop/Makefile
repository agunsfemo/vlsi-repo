# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)

flip_flop:
	rm -rf bin/
	mkdir bin
	iverilog -o bin/flip_flop.vvp -s flip_flop -s dump -g2012 src/flip_flop.sv utils/dump_flip_flop.sv
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test_flip_flop vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus  bin/flip_flop.vvp
	! grep failure results.xml

show_graph:
	gtkwave flip_flop.vcd

synth:
	yosys -p "read_verilog -sv src/flip_flop.sv; proc; opt; show -colors 2 -width -signed"

clean:
	rm -rf bin/
	rm -rf *.vcd
	rm -rf *.xml
	rm -rf __pycache__

.PHONY: clean

	
