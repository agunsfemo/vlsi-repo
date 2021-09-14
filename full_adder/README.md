# Full Adder

The full adder operation takes in three single bit binary **a**, **b**, **c_in** and the output of 
the full adder operation is given by **sum** and  **c_out** where **sum = a ^ b ^ c_in**, 
and **c_out = (a & b)  + (a & c_in) + b & c_in)**. Note that the **^** symbol represents XOR operation. 
In this example, two intermediate wires **p** & **g** were implemented to simplify the full adder function. 
**p** is defined as  **A ^ B**, and **g** = **A & B**. 
Finally, the outputs of the function were defined as sum = p ^ c_in, and c_out = g | (p & c_in).

## SystemVerilog code

In this module, there are two internal signals (p & g). Internal signals are declared 
using the logic type. Moreover, these signals serve as temporary variables 
(local variables) used to compute a portion of the results.

      `timescale 1ns/1ps
      module full_adder
            #(parameter W = 1)
            (input logic [W-1:0] a, b, c_in,
            output logic [W-1:0] sum, c_out);
            logic [W-1:0] p, g;
                        assign p = a ^ b;
                        assign g = a & b;
            assign sum = p ^ c_in;
            assign c_out = g | (p & c_in);
      endmodule

## Python Model code

      def full_adder(a, b, c_in):
          sum = a ^ (b ^ c_in)
          c_out = (a & b) | ((a ^ b) & c_in)
      return sum, c_out
      
## Python Testbench

        import cocotb
      from cocotb.clock import Clock
      from cocotb.triggers import Timer
      from model.full_adder_model import full_adder
      from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
      import random

      @cocotb.test()
      async def f_adder_basic_test(dut):
        a = 1
        b = 1
        c_in = 1
        dut.a <= a
        dut.b <= b
        dut.c_in <= c_in

        await Timer(2, units='ns')
        sum, c_out = full_adder(a, b, c_in)
        assert dut.sum.value == sum, "full_adder result is incorrect: {dut.y.value}"
        assert dut.c_out.value == c_out

      @cocotb.test()
      async def f_adder_randomised_test(dut):
        for i in range(50):
          a = random.randint(0, 1)
          b = random.randint(0, 1)
          c_in = random.randint(0, 1)
          dut.a <= a
          dut.b <= b
          dut.c_in <= c_in
          await Timer(2, units='ns')
        sum, c_out = full_adder(a, b, c_in)
        assert dut.sum.value == sum, "full_adder result is incorrect: {dut.y.value}"
        assert dut.c_out.value == c_out
        
## Results

## GTKwave
![Screenshot from 2021-09-14 04-26-28](https://user-images.githubusercontent.com/88589656/133190369-42a9bc26-e5af-41cc-a159-d6b2faba4c4f.png)

## Synth
![Screenshot from 2021-09-14 04-26-46](https://user-images.githubusercontent.com/88589656/133190391-2e6815db-3a79-440d-b9ee-54f9ebcf0e87.png)
