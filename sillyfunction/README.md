# Combinational Logic
## Sillyfunction
This example is a behavioral module that defines the Boolean Function y = A’B’C’ + AB’C’ + AB’C. 
The module name is **sillyfunction** and it has 1 bit three inputs, A, B, C, and one output, y. 
The bit length of the input and output variable was declared using the **parameter** statement.

>Note, the function is true when the input is 000, 100, or 101.

## SystemVerilog:
The sillyfuction module indicates the three inputs ports by using the word **input**. 
The output port is defined using the word **output** and the "logic" (0 or 1) type indicates 
the type of signal. 
Next, the **assign** statement describes combinational logic. This statement defines the Boolean function, and the output is 
assigned to the output port **y**. As explained in the introductory README file, **~** indicates **NOT**, **&** indicates
**AND**, and **|** indicates **OR**.


    `timescale 1ns/1ps
      module sillyfunction #(parameter WIDTH = 1)
                    (input logic [WIDTH-1:0] a, b, c,
                     output logic [WIDTH-1:0] y);
      assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c;
      endmodule
      
## Python:

The sillyfunction function in python only requires the input parameters and the returned output value (0 or 1) after the evaluation. 
The same function was defined using python Boolean operators to evaluate the inputs.

      def sillyfunction(a, b, c):
      return (not a and not b and not c) \
              or (a and not b and not c) \
              or (a and not b and c)
              
## Python Testbench:

This testbench feeds random inputs (0 or 1) to the device every 2ns. 
The for-loop repeats the input procedure 8 times. Moreover, the python function is called
with the same inputs (arguments) as the dut. The last part of the code uses an assert 
statement to evaluate if the output from the python and SV are the same. If the output is
not the same, then the test will fail and display a predefined error message. 
  
  import cocotb
  from cocotb.clock import Clock
  from cocotb.triggers import Timer
  from model.sillyfunction_model import sillyfunction
  from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
  import random

  @cocotb.test()
  async def silly_basic_test(dut):
      a = 1
      b = 1
      c = 1
      dut.a <= a
      dut.b <= b
      dut.c <= c

      await Timer(2, units='ns')

      assert dut.y.value == sillyfunction(a, b, c), "Sillyfunction " \
                                                  "result is incorrect: " \
                                                  "{dut.y.value}"


      @cocotb.test()
      async def silly_randomised_test(dut):
      for i in range(50):
        a = random.randint(0, 1)
        b = random.randint(0, 1)
        c = random.randint(0, 1)
        dut.a <= a
        dut.b <= b
        dut.c <= c

        await Timer(2, units='ns')

        assert dut.y.value == sillyfunction(a, b, c), "Randomised test " \
                                                      "failed with: {a}, " \
                                                      "{b}, {c}"

## Results:
### GTKwave Result
![Screenshot from 2021-09-14 03-29-14](https://user-images.githubusercontent.com/88589656/133184859-a7942c13-c5f5-4709-aa5f-6badfb5c52ac.png)

### Synth Result
![Screenshot from 2021-09-14 03-31-43](https://user-images.githubusercontent.com/88589656/133185051-3c8aafcb-db7a-462b-9c11-880e5aa67cb0.png)
