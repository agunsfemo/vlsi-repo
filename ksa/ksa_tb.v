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
