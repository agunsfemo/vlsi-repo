# Full Adder (Using Nonblocking Assignments)

This example is similar to the previous full adder operation but differs in that this 
example uses the nonblocking assignment statement which leads to an incorrect modelwith timing issue. 
Note that nonblocking assignments are only used for sequential logic. A sequential logic operation
is an operation whose output depends on the present state as well as the previous state. 
This, when used without caution can lead to error in the output of our device.

This module replaces all the blocking assignments in the previous example with nonblocking assignments. 
Note that nonblocking assignments can only be implemented inside an always statement. 
In this case, the always_comb (combinational) statement will react to any change in the 
input ports, a, b, and c_in. This always statement is the short version for always @(a, b, cin). 
Every time an input value changes, this type of always statement is used to compute the 
respective combinational logic (p, g, sum, and c_out). The use of nonblocking assignments
implies that the statments are evaluated concurrently. This means that the evaluation/computing of p, g, sum, and cout
will be at the same time (leaving the new values from p and g out of the scope for sum and 
c_out). The issue with using nonblocking assignments for combinational logic is the number 
of times each statement must be evaluated to obtain the correct output. For example, 
assume the input is 100 (a, b, c_in), then after evaluation, p=1, g=0, sum=0, and c_out=0. 
The sum is incorrect, but this is because the value of p was changed from 0 to 1 during 
the evaluation. Only during a second evaluation, the sum will be computed using the previous
value obtained from p=1. Moreover, the value of p will be updated in c_out after the second 
evaluation, and updating the value of p, results in sum=1, and c_out=0. This is the reason 
why using the wrong assignment can lead to multiple evaluations result in more 
time-consuming simulations.

## SystemVerilog:

      `timescale 1ns/1ps
      module full_adder_a34
           #(parameter SIZE = 1)
           (input logic [SIZE-1:0]a, b, c_in,
           output logic [SIZE-1:0]sum, c_out);
        logic[SIZE-1:0]p, g;
                always_comb
                    begin
                    	p <= a ^ b;  //nonblocking
            		      g <= a & b;  //nonblocking

            		      sum <= p ^ c_in;
            		      c_out <= g | (p & c_in);
                end

      endmodule
      
## Python Model code
This fulladder_a34 function replicates the behavior of the SV code. This function uses 
multiple global variables to keep track of previous values. 
Remember that blocking assignments required previous inputs to determine the output.

       a_prev, b_prev, cin_prev = 0, 0, 0
       p, g = 0, 0
       psum, pcout = 0, 0
       delay = 0

      def fulladder_34(a, b, c_in):
        global a_prev, b_prev, cin_prev
        global delay
        global  p, g
        global psum, pcout
        temp_p, temp_g = 0, 0

        temp_p = p
        temp_g = g

         if delay==0:
            delay = 1

            #Store input values
            a_prev = a
            b_prev = b
            cin_prev = c_in

            #Compute p & g
            p = a ^ b
            g = a & b
            return p, g, psum, pcout, temp_p, temp_g, 11

        elif (a != a_prev) | (b != b_prev) | (c_in != cin_prev):
            #Store input values
            a_prev = a
            b_prev = b
            cin_prev = c_in

            #Compute Sum, CarryOut, p, & g
            psum = temp_p ^ c_in
            pcout = temp_g | (temp_p & c_in)
            p = a ^ b
            g = a & b
            return p, g, psum, pcout, temp_p, temp_g, 22
        else:
            #NO change in inputs, therefore Outputs stays same
            return  temp_p, temp_g, psum, pcout, temp_p, temp_g, 33
            
 ## Python Testbench
    
import cocotb
from cocotb.triggers import Timer
from model.fulladder_a34_model import fulladder_a34
import random


@cocotb.test()
async def fulladder_34_tb(dut):
    for i in range(50):
        a = random.randint(0, 1)
        b = random.randint(0, 1)
        c = random.randint(0,1)
        dut.a <= a
        dut.b <= b
        dut.cin <= c

        await Timer(2, units='ns')

        cycle = i+1
        p, g, psum, pcout, tp, tg, lv = fulladder2(a, b, c)
        assert dut.p.value == p, f"output was incorrect on the {cycle}th cycle\n" \
                                 f"Executed level: {lv}\n" \
                                 f"SV P is: {dut.p.value}, " \
                                 f"Python P is : {p}"
        assert dut.g.value == g, f"output was incorrect on the {cycle}th cycle\n" \
                                 f"Executed level: {lv}\n" \
                                 f"SV P is: {dut.g.value}, " \
                                 f"Python P is : {g}"

        # to solve the 'x' issue change COCOTB_RESOLVE_X to "ZEROS"
        assert dut.sum.value == psum, f"output was incorrect on the {cycle}th cycle\n" \
                                      f"Executed level: {lv}\n" \
                                      f"Prev p, g: {tp}, {tg}\n" \
                                      f"Inputs: {a} {b} {c}\n" \
                                      f"SV sum is: {dut.sum.value} ({dut.p.value}_{dut.g.value}_{dut.sum.value}_{dut.cout.value}), " \
                                      f"Python sum is : {psum} ({p}_{g}_{psum}_{pcout})"
        assert dut.cout.value == pcout, f"output was incorrect on the {cycle}th cycle\n" \
                                        f"Executed level: {lv}\n" \
                                        f"Prev p, g: {tp}, {tg}\n" \
                                        f"Inputs: {a} {b} {c}\n" \
                                        f"SV Cout is: {dut.cout.value} ({dut.p.value}_{dut.g.value}_{dut.sum.value}_{dut.cout.value}), " \
                                        f"Python Cout is : {pcout} ({p}_{g}_{psum}_{pcout})"
 
 
## Results
 
## GTKwave
![Screenshot from 2021-09-14 05-28-55](https://user-images.githubusercontent.com/88589656/133195436-b433c304-c770-4b6b-88ec-a0814441e298.png)

## Synth
 ![Screenshot from 2021-09-14 04-26-46](https://user-images.githubusercontent.com/88589656/133195505-db6de62c-4445-48a2-bb4f-95ba4d8e2e1c.png)

 
