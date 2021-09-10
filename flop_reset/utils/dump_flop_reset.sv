module dump();
	initial begin
	    $dumpfile ("flop_reset.vcd");
	    $dumpvars (0, flop_reset);
	    #1;
	end
endmodule
	
