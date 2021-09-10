`timescale 1ns/1ps
module flop_reset
                #(parameter SIZE = 3)
                (input logic clk, reset,
                input logic [SIZE:0] d,
                output logic [SIZE:0] q);
      always_ff @(posedge clk)
      begin
      if (reset == 1) q <= 4'b0;

        else q <= d;
      end

endmodule
	
