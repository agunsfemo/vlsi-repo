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
