# Ripple Carry Full Adder

## Introduction to Full Adder
The full adder operation takes in three single bit binary **a**, **b**, **c_in** and the output of the full adder operation is given by **sum** and  **c_out** where **sum = a ^ b ^ c_in**, and **c_out = (a & b)  + (a & c_in) + b & c_in)**. Note that the **^** symbol represents XOR operation. 

## Ripple Carry Adder
A ripple carry adder is a logic circuit in which the carry-out of each full adder is the carry in of the succeeding next most significant full adder. It is called a ripple carry adder because each carry bit gets rippled into the next stage.

In this example, a gate level boolean masking approach was used to for the computation of each single bit input **a**, and **b**. This was done by combining 2 shares of the inputs with an **XOR** gate. 

This example aims at showcasing boolean masked full-adder as follows:

## Verilog code:
    
        //This is the definition of a masked n-bit ripple carry full_adder
      module f_a(a0, a1, b0, b1, c_in, s, c_out);
      input a0, a1, b0, b1, c_in;
      output s, c_out;
      reg s, c_out, a,b,d, e, f;
      always @(*)
      begin
        a <= a0 ^ a1;
      	b <= b0 ^ b1;
      	d <= a & b;
      	e <= b & c_in;
      	f <= c_in & a;
      	s <= a ^ b ^ c_in;
      	c_out <= d | e | f;
      end
      endmodule


    module rca #(parameter N=4)(input [N-1:0] a0,a1,b0,b1, input c_in, output [N:0] sum);
    wire [N:0] carry;
    wire [N-1 : 0]s;
    assign carry[0] = c_in;
   
    genvar i;
    generate 
       for(i=0;i<N;i=i+1)
        begin     	
     	  f_a f(a0[i], a1[i], b0[i], b1[i], carry[i], s[i], carry[i+1]);
        end
        endgenerate
      assign sum = {carry[N], s};
    endmodule 
