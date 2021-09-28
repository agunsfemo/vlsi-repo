`timescale 1ns / 1ns
module m_rca_tb;
  reg [3:0]a0, a1, b0, b1;
  reg c_in;
  //reg a,b, d, e, f;
  wire [4:0]sum;
  m_rca mrca(.a0(a0), .a1(a1), .b0(b0), .b1(b1), .c_in(c_in), .sum(sum));
           
    initial
        begin
            $dumpfile ("m_rca_tb.vcd");
            $dumpvars (0, m_rca_tb);
            #0 a0 = 4'b0000;
            #0 a1 = 4'b0001;
            #0 b0 = 4'b0010;
            #0 b1 = 4'b0100;
            #0 c_in = 1'b0;
            #20 $finish ;
        end
        always #2 a0 = a0 + 1'b1;
	always #2 a1 = a1 + 1'b1;
	always #2 b0 = b0 + 1'b1;
	always #2 b1 = b1 + 1'b1;
	always #2 c_in = c_in + 1'b1;
endmodule
