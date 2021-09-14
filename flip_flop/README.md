# Registers

A register is a memory device that can be used to store more than one bit of information. 
A register is usually realized as several flip-flops with common control signals that 
control the movement of data to and from the register.
HDL synthesizers recognize certain idioms and turn them into specific sequential circuits.
Other coding styles may simulate correctly, but synthesize into circuits with blatant or
subtle errors. This section presents the proper idioms to describe registers and latches.
The vast majority of modern commercial systems are built with registers using positive
edge-triggered D flip-flops. The example below shows the idiom for such flip-flops.

## SystemVerilog code
The flip_flop module declares a the input port **d** and output port **q** as a 4-bit 
buses and dedicated 1-bit port **clk** for the clock. The size of the buses was declared 
using the **parameter** statement. 
This design incorporates the always_ff(…) statement to specify the condition that will 
trigger a defined procedure. Note that instead of blocking assignments and **assign** statement, 
Nonblocking assignment was used inside the **always** statement. 
In this case, the posedge clk indicates that the defined procedure will be executed every 
time the clock's positive edge (rising edge) is fed to the module. The defined procedure 
copies the value from port d to q. 
Note that **<=** (nonblocking assignment) is used instead of **=** (blocking assignment). 
In SV, nonblocking assignments are used for sequential logic, while blocking 
assignments are used for combinational logic.

        `timescale 1ns/1ps
        module flip_flop
            #(parameter SIZE = 4)
            (input logic [SIZE - 1: 0] d,
            input logic [SIZE - 4 : 0] clk,
            output logic [SIZE - 1: 0] q);
          always_ff @(posedge clk)
            begin
                q  <= d;
            end
        endmodule


## Python Model code

The flip_flop function replicates the behavior of the SV code. The input value is redirected
to the output since the python function doesn't require a clock.

      def flip_flop(d):
         return d
         
## Python Testbench:

This testbench uses a predefined function for the **clock**. The clock is imported from 
**cocotb**. Moreover, the clock is initialized inside the test function. 
In this case, the signal is feed to the clock port for a period of 10ns. Furthermore, 
the **await** statement uses the **FallingEgde()** trigger to wait until the clock transition
from 1 to 0. 

      import cocotb
      from cocotb.clock import Clock
      from cocotb.triggers import Timer
      from model.flip_flop_model import flip_flop
      from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
      import random

      @cocotb.test()
      async def ff_basic_test(dut):
      clock = Clock(dut.clk, 10, units="ns")
      cocotb.fork(clock.start())

      val = 1

      dut.d <= val

      await FallingEdge(dut.clk)

      assert dut.q.value == flip_flop(val), "Randomised " \
                                          "output q was incorrect on the" \
                                          "{}th cycle".format(i)

      @cocotb.test()
      async def ff_randomised_test(dut):
          clock = Clock(dut.clk, 10, units="ns")
          cocotb.fork(clock.start())
          for i in range(50):
              val = random.randint(0, 1)
              dut.d <= val
            await FallingEdge(dut.clk)
            assert dut.q.value == flip_flop(val), "Randomised " \
                                              "output q was incorrect on the" \
                                              "{}th cycle".format(i)
                                      
## Results

## GTKwave
![Screenshot from 2021-09-14 14-53-49](https://user-images.githubusercontent.com/88589656/133270896-86287cf5-b669-4aa6-b1e8-0ea099d7a865.png)

## Synth
![Screenshot from 2021-09-14 14-56-56](https://user-images.githubusercontent.com/88589656/133271308-4c60a049-03df-452c-815a-ce24b18292a1.png)

                         
