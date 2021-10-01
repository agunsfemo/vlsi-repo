# Pipelined N-bit Full Adder


## The Modular Design of Pipelined N-bit Full Adder.
The masked full adders can be chained together to create an N-bit masked adder that can add two masked N-bit numbers. Fig. 7 (top)
shows how to construct a 4-bit masked adder as an example. We pipeline the N-bit adder to yield a
throughput of one by adding registers between the full-adders corresponding to each bit (see Fig. 7
(bottom))

  ![Pipelined_arc](https://user-images.githubusercontent.com/88589656/135201049-37e41d5c-a9b9-4ee2-aadd-0921f96aa234.png)


This example aims at showcasing Pipelined masked full-adder as follows:

## Verilog code:
    
        //This is the definition of a masked n-bit ripple carry full_adder
    module pipe_rca #(parameter N= 4)(input [N-1:0] a0,a1,b0,b1, input clk1, clk2, clk3, clk4,clk5, output [N:0] sum);

    reg c_in;
    reg [3:0]s, s0, s1, c_out, a,b,d, e, f;  
    reg sum;
    always @ (posedge clk1)
    begin
    	c_in <= 1'b0;  
    	a[0] <= a0[0] ^ a1[0];
      	b[0] <= b0[0] ^ b1[0];
      	d[0] <= a[0] & b[0];
      	e[0] <= b[0] & c_in;
      	f[0] <= c_in & a[0];
      	s0[0] <= a0[0] ^ b0[0] ^ c_in;
      	s1[0] <= a1[0] ^ b1[0] ^ c_in;
      	s[0] <= s0[0] ^ s1[0];
      	c_out[0] <= d[0] | e[0] | f[0];
      end
  
      always @(posedge clk2)
      begin
    	a[1] <= a0[1] ^ a1[1];
      	b[1] <= b0[1] ^ b1[1];
      	d[1] <= a[1] & b[1];
      	e[1] <= b[1] & c_out[0];
      	f[1] <= c_out[0] & a[1];
      	s0[1] <= a0[1] ^ b0[1] ^ c_out[0];
      	s1[1] <= a1[1] ^ b1[1] ^ c_out[0];
      	s[1] <= s0[1] ^ s1[1];
      	c_out[1] <= d[1] | e[1] | f[1];
      end
  
    always @(posedge clk3)
      begin
    	a[2] <= a0[2] ^ a1[2];
      	b[2] <= b0[2] ^ b1[2];
      	d[2] <= a[2] & b[2];
      	e[2] <= b[2] & c_out[1];
      	f[2] <= c_out[1] & a[2];
      	s0[2] <= a0[2] ^ b0[2] ^ c_out[1];
      	s1[2] <= a1[2] ^ b1[2] ^ c_out[1];
      	s[2] <= s0[2] ^ s1[2];
      	c_out[2] <= d[2] | e[2] | f[2];
       end
  
      always @(posedge clk4)
      begin
    	a[3] <= a0[3] ^ a1[3];
      	b[3] <= b0[3] ^ b1[3];
      	d[3] <= a[3] & b[3];
      	e[3] <= b[3] & c_out[2];
      	f[3] <= c_out[2] & a[3];
      	s0[3] <= a0[3] ^ b0[3] ^ c_out[2];
      	s1[3] <= a1[3] ^ b1[3] ^ c_out[2];
      	s[3] <= s0[3] ^ s1[3];
      	c_out[3] <= d[3] | e[3] | f[3];
    end
     always @(posedge clk5)
    begin
  	sum <= {c_out[3], s};
    end
    endmodule 
    
## Testbench code:

        `timescale 1ns / 1ns
    module pipe_rca_tb;
    reg [3:0]a0, a1, b0, b1;
    reg clk1, clk2, clk3, clk4, clk5;
    wire [4:0]sum;
    integer i = 0;
    pipe_rca pipe_rca1(.a0(a0), .a1(a1), .b0(b0), .b1(b1), .sum(sum), .clk1(clk1), .clk2(clk2), .clk3(clk3), .clk4(clk4), .clk5(clk5));
        
      initial begin
		  $dumpfile ("pipe_rca_tb.vcd");
        	$dumpvars (0, pipe_rca_tb);	
    	    	a0 = 4'b0000;
            	a1 = 4'b0001;
            	b0 = 4'b0010;
            	b1 = 4'b0100;
		  clk1 = 1'b0;
    	    	forever #2 clk1 = ~clk1;
      end
     initial begin
    		clk2 = 1'b0;
    		forever #4 clk2 = ~clk2;
     end
      initial begin
    		clk3 = 1'b0;
    		forever #8 clk3 = ~clk3;
      end
     initial begin
    		clk4 = 1'b0;
    		forever #16 clk4 = ~clk4;
      end
      initial begin
    	  	clk5 = 1'b0;
    	  	forever #32 clk5 = ~clk5;
      end

        	initial begin
	  while (i < 4) begin 
    	  a0 <= a0 + 1'b1; @(posedge clk5);
    	  a1 <= a1 + 1'b1; @(posedge clk5);
    	  b0 <= b0 + 1'b1; @(posedge clk5);
      	b1 <= b1 + 1'b1; @(posedge clk5);
      	i += 1;
    	  end
    	  #1200 $finish ;
      	end

    endmodule
        
        
## gtkwave output
![pipeline_rca](https://user-images.githubusercontent.com/88589656/135200099-4392e892-49de-4954-b33a-51b8b2938cd4.png)
![pipeline_rca1](https://user-images.githubusercontent.com/88589656/135200104-1e862e66-222b-44ed-ac28-9f8cc16f0f8c.png)

