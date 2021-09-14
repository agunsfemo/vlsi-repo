# Resettable registers
When power is first applied to a flip-flop circuit, the state of the output of the flop 
is unknown which is indicated with **x** in SystemVerilog. Generally, it is good practice 
to use resettable registers so that on power up you can put your system in a known state. 
The reset may be either synchronous or asynchronous. Synchronous reset occurs on the rising
edge of the clock, while asynchronous reset occurs immediately. This example demonstrates 
the idioms for flip-flops with synchronous resets. Synchronous reset takes fewer transistors 
and reduces the risk of timing problems on the trailing edge of reset.

## SystemVerilog code

This module is similar to the flip_flop module covered in previous example. The difference, 
in this case, is the implementation of the reset port. Also, an **if-else** statement is implemented 
as the procedure of the **always** statement. The procedure assigns the 4-bit binary value **4'b0** to 
the output q if reset is 1 (True). Otherwise, the output q is the same as the input d.

      `timescale 1ns/1ps
      module flop_reset
                #(parameter SIZE = 3)
                (input logic clk, reset,
                input logic [SIZE:0] d,
                output logic [SIZE:0] q);
      always_ff @(posedge clk)
      if (reset) q <= 4'b0;
      else q <= d;
      endmodule
      
## Python Model code

This flop_reset function replicates the behavior of the flip-flop but only differ by 
returning the input value d when reset is 0.


    def flop_reset(d, reset):
    
        if reset: 
    		    return 0
        else:
    		    return d

## Python Testbench code

    import cocotb
    from cocotb.clock import Clock
    from cocotb.triggers import Timer
    from model.flop_reset_model import flop_reset
    from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
    import random

    @cocotb.test()
    async def ffr_basic_test(dut):
      clock = Clock(dut.clk, 10, units="ns")
      cocotb.fork(clock.start())

      val = 1
      dut.d <= val
      r = 0
      dut.reset <= r
      await FallingEdge(dut.clk)
      assert dut.q.value == flop_reset(val, r), "Randomised " \
                                          "output q was incorrect on the" \
                                          "{}th cycle"

    @cocotb.test()
    async def ffr_randomised_test(dut):
        clock = Clock(dut.clk, 10, units="ns")
        cocotb.fork(clock.start())
        for i in range(15):
          val = random.randint(0, 1)
          r = random.randint(0, 1)
          dut.d <= val
          dut.reset <= r
          await FallingEdge(dut.clk)
          assert dut.q.value == flop_reset(val, r), "Randomised " \
                                   "output q was incorrect on the" \
                                   "{}th cycle".format(i)
   
## Results

### GTKwave
![Screenshot from 2021-09-14 16-44-23](https://user-images.githubusercontent.com/88589656/133292035-6fa384fc-cdd4-4846-b3ca-21fc7ba08972.png)
![Screenshot from 2021-09-14 16-46-09](https://user-images.githubusercontent.com/88589656/133292034-5947f494-ee13-46f9-b6c7-8e9d772169e4.png)

### Synth


