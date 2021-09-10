# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)

gates:
	rm -rf bin/
	mkdir bin
	iverilog -o bin/gates.vvp -s gates -s dump -g2012 src/gates.sv utils/dump_gates.sv
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test_gates vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus  bin/gates.vvp
	! grep failure results.xml

show_graph:
	gtkwave gates.vcd

synth:
	yosys -p "read_verilog -sv src/gates.sv; proc; opt; show -colors 2 -width -signed"

clean:
	rm -rf bin/
	rm -rf *.vcd
	rm -rf *.xml
	rm -rf __pycache__

.PHONY: clean

	
