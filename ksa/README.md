# Kogge's Stone Adder(KSA)

## Introduction 
In computing, the Kogge–Stone adder (KSA) is a parallel prefix form of carry look-ahead adder. Other parallel prefix adders (PPA) include the Brent–Kung adder (BKA), the Han–Carlson adder (HCA), and the fastest known variation, the Lynch–Swartzlander spanning tree adder (STA).

The Kogge–Stone adder takes more area to implement than the Brent–Kung adder, but has a lower fan-out at each stage, which increases performance for typical CMOS process nodes. However, wiring congestion is often a problem for Kogge–Stone adders. 
An example of a 4-bit Kogge–Stone adder is shown in the diagram. Each vertical stage produces a "propagate" and a "generate" bit, as shown. The culminating generate bits (the carries) are produced in the last stage (vertically), and these bits are XOR'd with the initial propagate after the input (the red boxes) to produce the sum bits. E.g., the first (least-significant) sum bit is calculated by XORing the propagate in the farthest-right red box (a "1") with the carry-in (a "0"), producing a "1". The second bit is calculated by XORing the propagate in second box from the right (a "0") with C0 (a "0"), producing a "0". 

The diagram for Kogge's Stone adder is shown below.
![4_bit_Kogge_Stone_Adder_Example_new](https://user-images.githubusercontent.com/88589656/135697489-9459fc06-16bc-463b-9771-16a5440ee189.png)

## KSA Computing Expression:
An Adder is a fundamental block for an arithmetic operation and is the base of other mathematical operations like subtraction, multiplication and division. Kogge Stone Adder is analogous to both Parallel Prefix Adder (PPA) and Carry Look Ahead (CLA).

  A Parallel Prefix Adder (PPA) works in three main stages and could be named as the Pre-processing stage, Carry Graph stage and Post-processing stage.
  
  
  The pre-processing part will lead to the generation of the propagate (P) and generate (G) bits. The acquirement of the PPA carry bit differentiates it from other type of adders. It uses a parallel form of computing the carry bit that makes it performing addition arithmetic faster.
Pi and Gi generated from pre-processing block based on equation:
   
  Pi = xi XOR yi ............... (1)
    
    
  Gi = xi AND yi ................ (2)
   
    
   Stage 1: In this stage, carries corresponds to each bit is computed.stage 1 is named as carry look-a head processing. In this stage carry look a head adder methodology is used to propagate and generate carry. Carry look ahead adder compute the one or more carry before calculating the sum which reduce time to calculate the sum of large bit size.
Both carry operator contains two AND gates and one OR gate. Operator uses propagate and generate as interconnected signals and given by equations (3) & (4)
   
   
  Pi = Pi AND Pi-1 ..................(3)
    
    
  Gi = Gi OR (Pi AND Gi-1 )..........(4)
    
    
  Summation Process: In this final stage to calculate the sum and carryout of the input bits. This stage gives the final output of the adder. Generated carries are treated as final carries in the this stage. The sum bits (Si ) and carry bits (Ci ) are given by following equations-
    
    
  Si = Pi XOR Ci-1 ............... (7)
    
    
  Ci = gi ........................ (8)
    
    
While calculating carries bits, the circuit requires an initial carry i.e. **C_in**. Hence C_in is kept at **0** initially and therefore the initial carry bit i.e. **C0** = C_in. C_in is also used as a carry while executing initial summation bit i.e. **S0**.
  The verilog example presents the definition of a 4 bit Kogge Stone Adder as follows:
  ![4_bit_KSA](https://user-images.githubusercontent.com/88589656/135700711-f51ca0df-5d38-48e1-9e9b-0371f8a6c995.png)

## Verilog code:


       module ksa #(parameter N=4)(input [N-1:0] a,b, input c_in, output [N:0] sum);
  	reg [N-1:0] p,g,p1,g1,p2,g2,s;
  	reg [N-1:0] carry;
  	integer i;
   	always @(*)
   	begin
 
   	for(i=0;i<N;i=i+1)
   	begin
   	  p[i] <= a[i] ^ b[i];
   	  g[i] <= a[i] & b[i];
   	end  
   
   	for(i=0;i<N;i=i+1)
   	if (i == 0) 
   		begin
      		  p1[i] <= p[i];
    		  g1[i] <= g[i]; 
   		end
   	else 
   		begin
     		  p1[i] <= p[i] & p[i-1];
     		  g1[i] <= g[i] || (p[i] & g[i-1]);
   		end
   
   	for(i=0;i<N;i=i+1)
   	if (i == 0 )
   		begin
     		  p2[i] <= p1[i];
     		  g2[i] <= g1[i]; 
   		end
   	else 
   	if (i == 1 )
   		begin
     		  p2[i] <= p1[i];
     		  g2[i] <= g1[i]; 
   		end
   	else
   		begin 
   		  p2[i] <= p1[i] & p1[i-2];
   		  g2[i] <= g1[i] || (p1[i] & g1[i-2]);
   		end
   
   	for(i=0;i<N;i=i+1)
   	if (i == 0) 
   		begin
   		  s[i] <= p[i] ^ c_in;
   		  carry[i] <= g2[i];
   		end
   	else
   		begin
   		  s[i] <= p[i] ^ carry[i-1];
   		  carry[i] <= g2[i];
   		end
   	end
   	assign sum = {carry[N-1], s};
	endmodule 
    
## Testbench code:

       `timescale 1ns / 1ns
	module ksa_tb;
  	reg [3:0]a, b;
  	reg c_in;
  	wire [4:0]sum;
 	 ksa ksa1(.a(a), .b(b), .c_in(c_in), .sum(sum));
           
    	initial
        	begin
            	$dumpfile ("ksa_tb.vcd");
            	$dumpvars (0, ksa_tb);
            	#0 a = 4'b0000;
            	#0 b = 4'b0000;
            	#0 c_in = 1'b0;
            	#100 $finish ;
        	end
        	always #2 a = a + 2'b11;
		always #2 b = b + 3'b100;
	endmodule
        
## gtkwave and Yosys output
![KSA_GTKwave](https://user-images.githubusercontent.com/88589656/135700674-2f7426b1-dcd4-4195-9415-d94549a34089.png)
![KSA_yosys_synth](https://user-images.githubusercontent.com/88589656/135700675-0a7c26f2-8a2d-40de-b909-debab2ed2d5d.png)
