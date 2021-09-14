# Logic Gates

This example shows the behavioral implementation of several combinational logic gates. 
The designed gates include AND, OR, XOR NAND, NOR and XNOR gates. 
In this example, the input and output ports use only 1-bit .

## SystemVerilog code

      `timescale 1ns/1ps
      module gates
            #(parameter W = 1)
            (input logic [W-1:0] a, b,
             output logic [W-1:0] yand, yor, yxor, ynand,
              ynor, yxnor);
         assign yand = a & b;
         assign yor = a | b;
        assign yxor = a ^ b;
        assign ynand = ~(a & b);
        assign ynor = ~(a | b);
        assign yxnor = ~(a ^ b);
      endmodule
      
## Python code

      def gates(a, b):
        yand = a and b
        yor = a or b
        yxor = ((not a) and b) or (a and (not b))
        ynand = not (a and b)
        ynor = not (a or b)
        yxnor = not (((not a) and b) or (a and (not b)))
    return  yand, yor, yxor, ynand, ynor, yxnor

## Python Testbench

  import cocotb
  from cocotb.clock import Clock
    from cocotb.triggers import Timer
     from model.gates_model import gates
    from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
    import random

    @cocotb.test()
    async def gate_basic_test(dut):
      a = 1
       b = 1
      dut.a <= a
      dut.b <= b

      await Timer(2, units='ns')
      yand, yor, yxor, ynand, ynor, yxnor = gates(a, b)
      assert dut.yand.value == yand, "gates result is incorrect: {dut.y.value}"
      assert dut.yor.value == yor
      assert dut.yxor.value == yxor
      assert dut.ynand.value == ynand
      assert dut.ynor.value == ynor
      assert dut.yxnor.value == yxnor

    @cocotb.test()
    async def gate_randomised_test(dut):
      for i in range(50):
        a = random.randint(0, 1)
        b = random.randint(0, 1)
        dut.a <= a
        dut.b <= b
        await Timer(2, units='ns')
        yand, yor, yxor, ynand, ynor, yxnor = gates(a, b)
      assert dut.yand.value == yand, "gates result is incorrect: {dut.y.value}"
      assert dut.yor.value == yor
      assert dut.yxor.value == yxor
      assert dut.ynand.value == ynand
      assert dut.ynor.value == ynor
      assert dut.yxnor.value == yxnor
      
## Results
## GTKwave
![Screenshot from 2021-09-14 03-54-06](https://user-images.githubusercontent.com/88589656/133187229-7902133b-9d53-4e2b-87e8-2781542bf1a1.png)

## Synth
![Screenshot from 2021-09-14 03-54-18](https://user-images.githubusercontent.com/88589656/133187254-7d500eb9-d6a9-4e1e-af04-d144567b2d83.png)
