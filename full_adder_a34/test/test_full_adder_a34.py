import cocotb
from cocotb.triggers import Timer
from model.fulladder_a34_model import fulladder_a34
import random


@cocotb.test()
async def fulladder_34_tb(dut):
    for i in range(50):
        a = random.randint(0, 1)
        b = random.randint(0, 1)
        c = random.randint(0,1)
        dut.a <= a
        dut.b <= b
        dut.cin <= c

        await Timer(2, units='ns')

        cycle = i+1
        p, g, psum, pcout, tp, tg, lv = fulladder2(a, b, c)
        assert dut.p.value == p, f"output was incorrect on the {cycle}th cycle\n" \
                                 f"Executed level: {lv}\n" \
                                 f"SV P is: {dut.p.value}, " \
                                 f"Python P is : {p}"
        assert dut.g.value == g, f"output was incorrect on the {cycle}th cycle\n" \
                                 f"Executed level: {lv}\n" \
                                 f"SV P is: {dut.g.value}, " \
                                 f"Python P is : {g}"

        # to solve the 'x' issue change COCOTB_RESOLVE_X to "ZEROS"
        assert dut.sum.value == psum, f"output was incorrect on the {cycle}th cycle\n" \
                                      f"Executed level: {lv}\n" \
                                      f"Prev p, g: {tp}, {tg}\n" \
                                      f"Inputs: {a} {b} {c}\n" \
                                      f"SV sum is: {dut.sum.value} ({dut.p.value}_{dut.g.value}_{dut.sum.value}_{dut.cout.value}), " \
                                      f"Python sum is : {psum} ({p}_{g}_{psum}_{pcout})"
        assert dut.cout.value == pcout, f"output was incorrect on the {cycle}th cycle\n" \
                                        f"Executed level: {lv}\n" \
                                        f"Prev p, g: {tp}, {tg}\n" \
                                        f"Inputs: {a} {b} {c}\n" \
                                        f"SV Cout is: {dut.cout.value} ({dut.p.value}_{dut.g.value}_{dut.sum.value}_{dut.cout.value}), " \
                                        f"Python Cout is : {pcout} ({p}_{g}_{psum}_{pcout})"
 
 
