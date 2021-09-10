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