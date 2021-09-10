module dump();
	initial begin
	    $dumpfile ("flip_flop.vcd");
	    $dumpvars (0, flip_flop);
	    #1;
	end
endmodule
	
