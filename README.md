
# SystemVerilog Code and output
## Introduction
This repository showcase some examples SystemVerilog HDL. HDLs are better understood as a shorthand for describing digital hardware. 
Each example was written in SystemVerilog (i.e, the .SV file). Also, a Python model code was also written to perform the same device behaviour. A testbench file is also written to compare the output of the Python code and the SystemVerilog module. The testbench file is required to run a simulation and verify if the SV code works as we intended. All the testbenches codes were created using python library named cocotb because complex tests could be made simpler and several random tests could be automatically generated using basic for loop iterations.

## List of examples covered

1. Combinational Logic
2. Logic Gates
3. Full Adder
4. Register
5. Resettable Register
6. Full Adder (Using Nonblocking Assignments)
7. History FSM (Finite State Machine)

# Brief Background of SystemVerilog

## A) SystemVerilog Module (.SV file)

A block of hardware code with inputs and outputs definition is reffered to as a module. A module always begins with the **module** statement, followed by the given name of the module and its list of the inputs and outputs. 
The functionality of a module is described within the **module** statement and the **endmodule** statement 
Note that there are two styles for describing a module functionality and these include the behavioral and structural style.
1. **Behavioral Module Style**
> Behavioral models describe what a module does. In simple terms, the module's functionality is fully described in the same module using the desired operators and statements. The image below showcases the behavioral modeling style. This module uses an “assign” statement to describe a 3-input AND gate using the logic **&** operator for the **AND** operation.
> 
![Screenshot from 2021-09-13 20-44-45](https://user-images.githubusercontent.com/88589656/133176068-81a8392c-037d-4a2d-8dbe-1d6025464ea9.png)

2. **Structural Module Style**
> Structural models describes a module using predefined modules (inbuilt or userdefined). Simply put, whenever a module calls a different sub-module to describe its functionality, we are writing structural style of module. It is important to know that the module that is called must be defined elsewhere in the code. The image below is an example of structural modeling of AND gate operation. **ANDgate** module uses the **AND3** module to describe its functionality. Note that **AND3** inside the **ANDgate** was used with **results** being a given arbitrary name. This is what is being reffered to as an instance of a module.

> ![Screenshot from 2021-09-13 21-05-49](https://user-images.githubusercontent.com/88589656/133176289-fcec4bf9-64af-43eb-864b-2726ffeda371.png)

## B) SystemVerilog Operator Precedence
The operator precedence for SystemVerilog is much like you would expect in other programming languages. In particular, as shown in Table below, the precedence tables include other arithmetic, shift, and comparison operators.

![Screenshot from 2021-09-13 22-09-23](https://user-images.githubusercontent.com/88589656/133177700-28ccdc34-dc9e-4c7a-9dd2-5c9921a17e3e.png)

## C) Python model code (.py file)

When designing our circuits using SystemVerilog, the behavioral style of coding might come handy due to its simplicity and easy to understand. After the SystemVerilog code which defines the device is done, you need to write the testbench. The approach to this is to write a similar design of the SystemVerilog code in another similar coding language (we shall be using python in this case) and test for similar inputs on the python side if the code works perfectly by instantiating the two codes and match their results.

![Screenshot from 2021-09-14 02-03-58](https://user-images.githubusercontent.com/88589656/133177501-1d136807-e43a-41c3-bd6f-f0c59532b85d.png)

## D) Python Testbench code (.py file)

The test code like the model code is also written in python language and this contain codes from cocotb. cocotb is a testbench generator in python. The cocotb takes all the complexity of writing textbench and give its equivalent python script that automatically performs the testing. The python test code file contains some pre-written codes and all we need to do is to import the cocotb library. The basic structure of the test code is shown below.

![Screenshot from 2021-09-14 02-13-43](https://user-images.githubusercontent.com/88589656/133178438-9e680e43-61ef-4869-8385-a18fd7851f65.png)

![Screenshot from 2021-09-14 02-25-21](https://user-images.githubusercontent.com/88589656/133179407-e635ec67-033e-4df9-afd7-8dc2b42e2439.png)

As you can see, the basic structure starts with @cocotb.test () asynch def which is the test definition code for python, followed by name(dut): where dut means design under test. A basic test is done by passing single test values to input pin a and b. We will then assign these values to the device under test using dut.a <= a and dut.b <= b and then wait for 2 ns. Next, you carry out the test by using the assert statement. The test is done by checking if the output value of y in the design under test is the same with the output in the python model script when values are assigned to input pin a and b.

Furthermore, an elaborate test will be carried out using randomly generated values for a and b and the test will be carried out for n number of times (in this case, 1000 times) using a for loop statement. For each random test carried out, the output of the python model script is compared with the output of the dut. The randomized test is needed to be more sure that the SystemVerilog design is correct.

![Screenshot from 2021-09-14 02-29-02](https://user-images.githubusercontent.com/88589656/133179942-dc113449-8cba-457b-9c40-b8908ba01be1.png)

## E) Makefile
The makefile is used to run the cocotb variables and the Verilog codes when then name of the routine is passed to it. Note that under the example_02_adder routine, we have used the iverilog command with the input .sv source file to create the output .vvp file. other routines can be passed to be executed using the makefile for example, when we use the show_graph routine, the gtkwave command will be invoked to show the graph of the output result in the .vcd file. 
The digital design can be synthesized to display the logic gate design by the yosys command under the synth routine.

![Screenshot from 2021-09-14 02-44-34](https://user-images.githubusercontent.com/88589656/133180982-e4204e8f-aefd-4e58-ad7e-5b5c5801fc00.png)

# References
* cocotb:
  * Documentation
  * Github
* HDL Intro
