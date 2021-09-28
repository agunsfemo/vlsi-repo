m_rca:
	iverilog -o m_rca.vvp m_rca_tb.v m_rca.v
	vvp m_rca.vvp
synth:
	yosys -p "read_verilog m_rca.v ; proc ; opt ; show -colors 2 -width -signed"
show_graph:
	gtkwave m_rca_tb.vcd

