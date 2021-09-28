pipe_rca:
	iverilog -o pipe_rca.vvp pipe_rca_tb.v pipe_rca.v
	vvp pipe_rca.vvp
synth:
	yosys -p "read_verilog pipe_rca.v ; proc ; opt ; show -colors 2 -width -signed"
show_graph:
	gtkwave pipe_rca_tb.vcd

