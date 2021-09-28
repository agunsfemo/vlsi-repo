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
