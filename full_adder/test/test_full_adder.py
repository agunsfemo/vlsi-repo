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
