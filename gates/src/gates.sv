`timescale 1ns/1ps
module gates
            #(parameter W = 1)
            (input logic [W-1:0] a, b,
             output logic [W-1:0] yand, yor, yxor, ynand,
              ynor, yxnor);
      assign yand = a & b;
      assign yor = a | b;
      assign yxor = a ^ b;
      assign ynand = ~(a & b);
      assign ynor = ~(a | b);
      assign yxnor = ~(a ^ b);
endmodule
	
