# Kogge's Stone Adder(KSA)

## Introduction 
In computing, the Kogge–Stone adder (KSA) is a parallel prefix form carry look-ahead adder. Other parallel prefix adders (PPA) include the Brent–Kung adder (BKA), the Han–Carlson adder (HCA), and the fastest known variation, the Lynch–Swartzlander spanning tree adder (STA).

The Kogge–Stone adder takes more area to implement than the Brent–Kung adder, but has a lower fan-out at each stage, which increases performance for typical CMOS process nodes. However, wiring congestion is often a problem for Kogge–Stone adders. 
An example of a 4-bit Kogge–Stone adder is shown in the diagram. Each vertical stage produces a "propagate" and a "generate" bit, as shown. The culminating generate bits (the carries) are produced in the last stage (vertically), and these bits are XOR'd with the initial propagate after the input (the red boxes) to produce the sum bits. E.g., the first (least-significant) sum bit is calculated by XORing the propagate in the farthest-right red box (a "1") with the carry-in (a "0"), producing a "1". The second bit is calculated by XORing the propagate in second box from the right (a "0") with C0 (a "0"), producing a "0". 

The diagram for Kogge's Stone adder is shown below.
![4_bit_Kogge_Stone_Adder_Example_new](https://user-images.githubusercontent.com/88589656/135697489-9459fc06-16bc-463b-9771-16a5440ee189.png)



## Verilog code:
       //This is the definition of a 4-bit ripple carry full_adder
	module f_a(a,b, c_in, s, c_out);
      	input a,b, c_in;
      	output s, c_out;
      	reg s, c_out, d, e, f;
      	always @(*)
      	begin
      	d <= a & b;
      	e <= b & c_in;
      	f <= c_in & a;
      	s <= a ^ b ^ c_in;
      	c_out <= d | e | f;
      	end
	endmodule


	module rca #(parameter N=4)(input [N-1:0] a,b,  output [N:0] sum);
  	wire [N:0] carry;
  	wire [N-1 : 0]s;
  	assign carry[0] = 1'b0;
   
  	 genvar i;
  	 generate 
  	 for(i=0;i< N;i=i+1)
  	 begin
  	 f_a f(a[i], b[i], carry[i], s[i], carry[i+1]);
     	 end
     	 endgenerate
   	assign sum = {carry[N], s};
	endmodule 
        
    
## Testbench code:

       `timescale 1ns / 1ns
	module rca_tb;
  	reg [3:0]a, b;
  	reg c_in;
  	wire [4:0]sum;
  	rca rca1(.a(a), .b(b), .sum(sum));
           
    	initial
        	begin
        	    $dumpfile ("rca_tb.vcd");
        	    $dumpvars (0, rca_tb);
        	    #0 a = 4'b0000;
        	    #0 b = 4'b0001;
        	    #20 $finish ;
        	end
     	always #2 a = a + 1'b1;
	always #2 b = b + 1'b1;
	endmodule
        
## gtkwave output
![gtkwave](https://user-images.githubusercontent.com/88589656/135176483-edbc1b93-29d4-411c-9d79-e6ef7335a675.png)
![gtkwave1](https://user-images.githubusercontent.com/88589656/135177105-0382e01d-2f54-4eac-ae4b-b4791bb08601.png)



