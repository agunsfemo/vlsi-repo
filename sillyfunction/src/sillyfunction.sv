`timescale 1ns/1ps
module sillyfunction #(parameter WIDTH = 1)
                    (input logic [WIDTH-1:0] a, b, c,
                     output logic [WIDTH-1:0] y);
   assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c;
endmodule
	
