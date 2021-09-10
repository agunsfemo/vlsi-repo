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
    reset = 0
    dut.reset <= reset
    await FallingEdge(dut.clk)

    assert dut.q.value == flop_reset(val), "Randomised " \
                                          "output q was incorrect on the" \
                                          "{}th cycle"

@cocotb.test()
async def ffr_randomised_test(dut):
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.fork(clock.start())
    for i in range(15):
        val = random.randint(0, 1)
        dut.d <= val
        await FallingEdge(dut.clk)
        assert dut.q.value == flop_reset(val), "Randomised " \
                                   "output q was incorrect on the" \
                                   "{}th cycle".format(i)
    val = 1
    dut.d <= val
    dut.reset <= 1
    await FallingEdge(dut.clk)
    assert dut.q.value == 0



