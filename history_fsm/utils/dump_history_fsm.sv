module dump();
	initial begin
	    $dumpfile ("history_fsm.vcd");
	    $dumpvars (0, history_fsm);
	    #1;
	end
endmodule
	
