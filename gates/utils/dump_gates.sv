module dump();
	initial begin
	    $dumpfile ("gates.vcd");
	    $dumpvars (0, gates);
	    #1;
	end
endmodule
	
