`timescale 1ns/1ps
module flip_flop
            #(parameter SIZE = 4)
            (input logic [SIZE - 1: 0] d,
            input logic [SIZE - 4 : 0] clk,
            output logic [SIZE - 1: 0] q);
          always_ff @(posedge clk)
            begin
                q  <= d;
            end
endmodule
	
