# History FSM (Finite State Machine)

This example covers the design for a finite state machine. To be more specific, the design implemented is a Mealy machine. This means that the output is a function of the current state and inputs. The image below shows the transition diagram of the Mealy machine implemented in this example. This machine has an input a and two outputs, x and y. Output x is true when the input is the same now as it was in the last cycle. Output y is true when the input is the same now as it was for the past two cycles. If the machine is reset, the cycle will start from 0.

![Screenshot from 2021-09-14 18-54-33](https://user-images.githubusercontent.com/88589656/133309471-3523d3bb-dac9-4692-a8af-4f8df2331ff7.png)


## SystemVerilog code

In this module, the **typedef** statement defines **statetype** as a 3-bit logic value with one of four possibilities: **s0**, **s1**, **s2**, **s3**, or **s4**. The enum (enumerate) encodings default to numerical order: **s0=000**, **s1=001**, **s2=010**, **s3=011**, or **s4=100**. Next, the state and nextstate are declared as statetype signals. To get the nextstate of the current state, a case statement is used to define the state transition.


      `timescale 1ns/1ps
      module history_fsm(input logic clk,
		          input logic reset, 
		          input logic a,
		          output logic x, y);
	
	      typedef enum logic [2:0]
	        {s0, s1, s2, s3, s4} statetype;
	        statetype state, nextstate;
	  
      // State Register
      always_ff @(posedge clk)
 	      if (reset) state <= s0;
 	      else       state <= nextstate;
 	
      //Next State Logic
      always_comb
        case (state)
          s0: if (a) nextstate = s3;
     	        else   nextstate = s1; 
          s1: if (a) nextstate = s3;
     	        else   nextstate = s2;
          s2: if (a) nextstate = s3;
     	        else   nextstate = s2;
          s3: if (a) nextstate = s4;
     	        else   nextstate = s1;
          s4: if (a) nextstate = s4;
     	        else   nextstate = s1;
          default:    nextstate = s0;
        endcase

      // Output Logic
      assign x = ((state == s1 | state == s2) & ~a) |
	          ((state == s3 | state == s4) & a);
      assign y = (state == s2 & ~a) | (state == s4 & a);
      endmodule
      
      
## Python Model code
The history_fsm function replicates the behavior of the SV code. This function uses multiple global variables to keep track of previous values.
      
    state, nextstate = 0, 0
    num_calls = 0
    start = 1
    a_prev = 0
    def history_fsm(rst, a):
    global state, nextstate
    global start
    global num_calls
    global a_prev

    #Store the previous values of state & nextstate
    temp_s, temp_n = state, nextstate

    if start:
        start = 0
        if rst:
            state = 0
        else:
            state = nextstate

        if state == 0:
            nextstate = 3 if a else 1
        elif state == 1:
            nextstate = 3 if a else 2
        elif state == 2:
            nextstate = 3 if a else 2
        elif state == 3:
            nextstate = 4 if a else 1
        elif state == 4:
            nextstate = 4 if a else 1
        else:
            nextstate = 0
    else:
        if rst:
            state = 0
        else:
            state = nextstate

        if (rst==0) & (a != a_prev):
            for i in range(2):
                state = nextstate

                if state == 0:
                    nextstate = 3 if a else 1
                elif state == 1:
                    nextstate = 3 if a else 2
                elif state == 2:
                    nextstate = 3 if a else 2
                elif state == 3:
                    nextstate = 4 if a else 1
                elif state == 4:
                    nextstate = 4 if a else 1
                else:
                    nextstate = 0
        else:
            if state == 0:
                nextstate = 3 if a else 1
            elif state == 1:
                nextstate = 3 if a else 2
            elif state == 2:
                nextstate = 3 if a else 2
            elif state == 3:
                nextstate = 4 if a else 1
            elif state == 4:
                nextstate = 4 if a else 1
            else:
                nextstate = 0

    num_calls += 1
    a_prev = a
    x = (((state == 1) | (state == 2)) & (not a)) | (((state == 3) | (state == 4)) & a)
    y = ((state == 2) & (not a)) | ((state == 4) & a)
    return int(x), int(y), state, nextstate, temp_s, temp_n, num_calls

## Python Testbench code

This testbench follows the same procedure explained in the previous examples. However, a print function was implemented to track all the inputs and their respective outputs.

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
           px, py, pstate, nstate, ps, pn, n_c= history_fsm(r, a)  #Python model
           print(f"{cycle} cycle inputs (r, a): {r}, {a} -----> (sv state, next: { dut.state.value} {dut.nextstate.value})"\
              f"  (python state, next: {pstate}, {nstate})\n")

           assert dut.state.value == pstate, f"Output was incorrect on the {cycle}th (p={n_c}) cycle\n" \
                                          f"Inputs: {r}, {a}\n" \
                                          f"SV state is: {dut.state.value}" \
                                          f"Python state is: {pstate} (prev: state, next = {ps} {pn})"
            assert dut.nextstate.value == nstate, f"Output was incorrect on the {cycle}th (p={n_c}) cycle\n" \
                                             f"Inputs: {r}, {a}\n" \
                                             f"SV next is: {dut.nextstate.value}, " \
                                             f"Python next is: {nstate} (prev: state, next = {ps} {pn})"
            assert dut.x.value == px, f"Output was incorrect on the {cycle}th (p={n_c})  cycle\n" \
                                  f"Inputs: {r}, {a}\n" \
                                  f"SV x is: {dut.x.value}, " \
                                  f"Python x is: {px} (state, next = {pstate} {nstate})"
            assert dut.y.value == py, f"Output was incorrect on the {cycle}th (p={n_c})  cycle\n" \
                                  f"Inputs: {r}, {a}\n"\
                                  f"SV y is: {dut.y.value}, " \
                                  f"Python y is: {py} (state, next = {pstate} {nstate})"

## Results

### GTKwave
![Screenshot from 2021-09-14 18-32-36](https://user-images.githubusercontent.com/88589656/133312783-9558be04-cd2c-45a2-93dd-46443136111f.png)


### Synth
	
![Screenshot from 2021-09-14 18-34-28](https://user-images.githubusercontent.com/88589656/133312857-0636b252-9ff1-40ef-bf83-5b9b50f99e9b.png)
	
![Screenshot from 2021-09-14 18-38-23](https://user-images.githubusercontent.com/88589656/133312907-67a4555c-0561-4d93-9efc-bec195ad4c06.png)
	
![Screenshot from 2021-09-14 18-38-47](https://user-images.githubusercontent.com/88589656/133312947-9a07b66b-c0c4-4143-a089-d7932a8fab50.png)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
