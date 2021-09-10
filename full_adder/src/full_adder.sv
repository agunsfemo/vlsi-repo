`timescale 1ns/1ps
module full_adder
            #(parameter W = 1)
            (input logic [W-1:0] a, b, c_in,
            output logic [W-1:0] sum, c_out);
            logic [W-1:0] p, g;
                        assign p = a ^ b;
                        assign g = a & b;
            assign sum = p ^ c_in;
            assign c_out = g | (p & c_in);
endmodule
	
