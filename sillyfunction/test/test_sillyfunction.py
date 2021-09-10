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