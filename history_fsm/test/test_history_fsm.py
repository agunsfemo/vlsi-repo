import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer
from model.history_fsm_model import history_fsm
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
import random


@cocotb.test()
async def history_fsm_random_tb(dut):
    clock = Clock(dut.clk, 10, units="ns")  # Create a 10ns period clock on port clk
    cocotb.fork(clock.start())  # Start the clock

    for i in range(20):
        a = random.randint(0, 1)
        r = random.randint(0, 1)
        dut.a <= a
        dut.reset <= r

        await FallingEdge(dut.clk)

        cycle = i+1
        px, py, pstate, nextstate, ps, pn, n_c= history_fsm(r, a)  #Python model
        print(f"{cycle} cycle inputs (r, a): {r}, {a} -----> (sv state, next: { dut.state.value} {dut.nextstate.value})"\
              f"  (python state, next: {pstate}, {pnext})\n")

        assert dut.state.value == pstate, f"Output was incorrect on the {cycle}th (p={n_c}) cycle\n" \
                                          f"Inputs: {r}, {a}\n" \
                                          f"SV state is: {dut.state.value}" \
                                          f"Python state is: {pstate} (prev: state, next = {ps} {pn})"
        assert dut.nextstate.value == nextstate, f"Output was incorrect on the {cycle}th (p={n_c}) cycle\n" \
                                             f"Inputs: {r}, {a}\n" \
                                             f"SV next is: {dut.nextstate.value}, " \
                                             f"Python next is: {pnext} (prev: state, next = {ps} {pn})"
        assert dut.x.value == px, f"Output was incorrect on the {cycle}th (p={n_c})  cycle\n" \
                                  f"Inputs: {r}, {a}\n" \
                                  f"SV x is: {dut.x.value}, " \
                                  f"Python x is: {px} (state, next = {pstate} {pnext})"
        assert dut.y.value == py, f"Output was incorrect on the {cycle}th (p={n_c})  cycle\n" \
                                  f"Inputs: {r}, {a}\n"\
                                  f"SV y is: {dut.y.value}, " \
                                  f"Python y is: {py} (state, next = {pstate} {pnext})"

