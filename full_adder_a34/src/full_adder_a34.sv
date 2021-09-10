`timescale 1ns/1ps
module full_adder_a34
           #(parameter SIZE = 1)
           (input logic [SIZE-1:0]a, b, c_in,
           output logic [SIZE-1:0]sum, c_out);
        logic[SIZE-1:0]p, g;
                always_comb
                    begin
                    p = a ^ b;
                    g = a & b;
                    sum = p ^ c_in;
                    c_out = g | (p & c_in);
                end

endmodule
	
