module dump();
	initial begin
	    $dumpfile ("full_adder_a34.vcd");
	    $dumpvars (0, full_adder_a34);
	    #1;
	end
endmodule
	
