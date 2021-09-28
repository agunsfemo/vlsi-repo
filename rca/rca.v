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
   for(i=0;i<N;i=i+1)
     begin     	
     	f_a f(a[i], b[i], carry[i], s[i], carry[i+1]);
     end
     endgenerate
   assign sum = {carry[N], s};
endmodule 
