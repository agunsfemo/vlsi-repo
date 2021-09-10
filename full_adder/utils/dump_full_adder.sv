module dump();
	initial begin
	    $dumpfile ("full_adder.vcd");
	    $dumpvars (0, full_adder);
	    #1;
	end
endmodule
	
