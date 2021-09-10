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
