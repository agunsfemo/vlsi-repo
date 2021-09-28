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


module pipe_rca #(parameter N=4)(input [N-1:0] a0,a1,b0,b1, input c_in, output [N:0] sum);
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


module pipe_rca #(parameter N= 4)(input [N-1:0] a0,a1,b0,b1, input c_in, clk1, clk2, output [N:0] sum);

    reg [N-1:0] a0, a1, b0, b1;
    reg c_in;
    //reg [3:0]pipe1, pipe2, pipe3;
    reg [3:0]s, c_out, a,b,d, e, f;  
    assign c_in[0] = 1'b0  
  always @ (posedge clk1)
  begin
    	a[0] <= a0[0] ^ a1[0];
      	b[0] <= b0[0] ^ b1[0];
      	d[0] <= a[0] & b[0];
      	e[0] <= b[0] & c_in[0];
      	f[0] <= c_in[0] & a[0];
      	s[0] <= a[0] ^ b[0] ^ c_in[0];
      	c_out[0] <= d[0] | e[0] | f[0];
   
 
