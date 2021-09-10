# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)

sillyfunction:
	rm -rf bin/
	mkdir bin
	iverilog -o bin/sillyfunction.vvp -s sillyfunction -s dump -g2012 src/sillyfunction.sv utils/dump_sillyfunction.sv
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test_sillyfunction vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus  bin/sillyfunction.vvp
	! grep failure results.xml

show_graph:
	gtkwave sillyfunction.vcd

synth:
	yosys -p "read_verilog -sv src/sillyfunction.sv; proc; opt; show -colors 2 -width -signed"

clean:
	rm -rf bin/
	rm -rf *.vcd
	rm -rf *.xml
	rm -rf __pycache__

.PHONY: clean

	
