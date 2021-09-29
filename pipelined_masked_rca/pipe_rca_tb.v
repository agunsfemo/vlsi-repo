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
