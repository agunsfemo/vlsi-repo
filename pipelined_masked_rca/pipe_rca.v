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
