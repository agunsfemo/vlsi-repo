# Masked Ripple Carry Full Adder

## Introduction
We adopt the ripple-carry style of implementation for the adder first. It is composed of N 1-bit full adders where the carry-out from each adder is the carry-in for the next adder in the chain, starting from LSB. Therefore, ripple-carry configuration eases parameterization and modular design of the Boolean masked adders.

![masked_rca](https://user-images.githubusercontent.com/88589656/135198003-88983159-048e-41c9-85b7-fc086659666c.png)

## Design of a Masked Full Adder
A 1-bit full adder takes as input two operands and a carry-in and generates the sum and the carry, which are a function of the two operands and the carry-in. If the input operand bits are denoted by 𝑎 and 𝑏 and carry-in bit by 𝑐, then the Boolean equation of
the sum 𝑆 and the carry 𝐶 can be described as follows:
![masked adder eqn](https://user-images.githubusercontent.com/88589656/135198246-7e03057b-7e8b-4965-8e90-980a1a686477.png)


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


	module m_rca #(parameter N=4)(input [N-1:0] a0,a1,b0,b1, output [N:0] sum);
  	wire [N:0] carry;
  	wire [N-1 : 0]s;
  	assign carry[0] = 1'b0;
   
   	genvar i;
   	generate 
   	for(i=0;i<N;i=i+1)
     	begin     	
     		f_a f(a0[i], a1[i], b0[i], b1[i], carry[i], s[i], carry[i+1]);
     	end
     	endgenerate
   	assign sum = {carry[N], s};
	endmodule 
    
## Testbench code:

        `timescale 1ns / 1ns
	module m_rca_tb;
  		reg [3:0]a0, a1, b0, b1;
  		wire [4:0]sum;
  		m_rca mrca(.a0(a0), .a1(a1), .b0(b0), .b1(b1), .sum(sum));
           
    		initial
       		begin
            	$dumpfile ("m_rca_tb.vcd");
            	$dumpvars (0, m_rca_tb);
            	#0 a0 = 4'b0000;
            	#0 a1 = 4'b0001;
            	#0 b0 = 4'b0010;
            	#0 b1 = 4'b0100;
            	#20 $finish ;
        	end
        	always #2 a0 = a0 + 1'b1;
		always #2 a1 = a1 + 1'b1;
		always #2 b0 = b0 + 1'b1;
		always #2 b1 = b1 + 1'b1;
	endmodule
        
        
## gtkwave output
![Screenshot from 2021-09-28 01-07-01](https://user-images.githubusercontent.com/88589656/135198742-002bcf03-a47a-4600-8f31-8d04f16f4c04.png)

