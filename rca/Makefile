rca:
	iverilog -o rca.vvp rca_tb.v rca.v
	vvp rca.vvp
synth:
	yosys -p "read_verilog rca.v ; proc ; opt ; show -colors 2 -width -signed"
show_graph:
	gtkwave rca_tb.vcd

