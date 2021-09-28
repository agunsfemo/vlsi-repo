# Ripple Carry Full Adder

## Introduction to Full Adder
The full adder operation takes in three single bit binary **a**, **b**, **c_in** and the output of the full adder operation is given by **sum** and  **c_out** where **sum = a ^ b ^ c_in**, and **c_out = (a & b)  + (a & c_in) + b & c_in)**. Note that the **^** symbol represents XOR operation. 

The logic gate combination of full-adder is shown below.
![F_A](https://user-images.githubusercontent.com/88589656/135161809-21c5e9af-f471-41df-92cd-fabb0f3d6720.png)


## Ripple Carry Adder
A ripple carry adder is a logic circuit in which the carry-out of each full adder is the carry in of the succeeding next most significant full adder. It is called a ripple carry adder because each carry bit gets rippled into the next stage.
Multiple full adder circuits can be cascaded in parallel to add an N-bit number. For an N- bit parallel adder, there must be N number of full adder circuits. A ripple carry adder is a logic circuit in which the carry-out of each full adder is the carry in of the succeeding next most significant full adder. It is called a ripple carry adder because each carry bit gets rippled into the next  stage. In a ripple carry adder the sum and carry out bits of any half adder stage is not valid until the carry in of that stage occurs.Propagation delays inside the logic circuitry is the reason behind this. Propagation delay is time elapsed between the application of an input and occurance of the corresponding output.
![RCA](https://user-images.githubusercontent.com/88589656/135162068-24ed5975-046e-40f1-8af3-d9af7dc049c2.png)
  (Cascaded) Ripple carry Full Adder.

  
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


