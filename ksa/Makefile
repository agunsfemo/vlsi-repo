ksa:
	iverilog -o ksa.vvp ksa_tb.v ksa.v
	vvp ksa.vvp
synth:
	yosys -p "read_verilog ksa.v ; proc ; opt ; show -colors 2 -width -signed"
show_graph:
	gtkwave ksa_tb.vcd

