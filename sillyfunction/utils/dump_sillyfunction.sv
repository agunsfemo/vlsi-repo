module dump();
	initial begin
	    $dumpfile ("sillyfunction.vcd");
	    $dumpvars (0, sillyfunction);
	    #1;
	end
endmodule
	
