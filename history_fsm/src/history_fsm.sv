`timescale 1ns/1ps
module history_fsm(input logic clk,
		    input logic reset, 
		    input logic a,
		    output logic x, y);
	
	typedef enum logic [2:0]
	   {s0, s1, s2, s3, s4} statetype;
	  statetype state, nextstate;
	  
 // State Register
 always_ff @(posedge clk)
 	if (reset) state <= s0;
 	else       state <= nextstate;
 	
 //Next State Logic
 always_comb
   case (state)
     s0: if (a) nextstate = s3;
     	  else   nextstate = s1; 
     s1: if (a) nextstate = s3;
     	  else   nextstate = s2;
     s2: if (a) nextstate = s3;
     	  else   nextstate = s2;
     s3: if (a) nextstate = s4;
     	  else   nextstate = s1;
     s4: if (a) nextstate = s4;
     	  else   nextstate = s1;
     default:    nextstate = s0;
   endcase

// Output Logic
assign x = ((state == s1 | state == s2) & ~a) |
	    ((state == s3 | state == s4) & a);
assign y = (state == s2 & ~a) | (state == s4 & a);
endmodule
	
