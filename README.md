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

x-special/nautilus-clipboard
copy
file:///home/olufemi/Pictures/Screenshot%20from%202021-09-13%2020-44-45.png

2. **Structural Module Style**
> Structural models describes a module using predefined modules (inbuilt or userdefined). Simply put, whenever a module calls a different sub-module to describe its functionality, we are writing structural style of module. It is important to know that the module that is called must be defined elsewhere in the code. The image below is an example of structural modeling of AND gate operation. **ANDgate** module uses the **AND3** module to describe its functionality. Note that **AND3** inside the **ANDgate** was used with **results** being a given arbitrary name. This is what is being reffered to as an instance of a module.

## B) SystemVerilog Operator Precedence
The operator precedence for SystemVerilog is much like you would expect in other programming languages. In particular, as shown in Table below, the precedence tables include other arithmetic, shift, and comparison operators.
> x-special/nautilus-clipboard
copy
file:///home/olufemi/Pictures/Screenshot%20from%202021-09-13%2022-09-23.png

## C) Python model code (.py file)

When designing our circuits using SystemVerilog, the behavioral style of coding might come handy due to its simplicity and easy to understand. After the SystemVerilog code which defines the device is done, you need to write the testbench. The approach to this is to write a similar design of the SystemVerilog code in another similar coding language (we shall be using python in this case) and test for similar inputs on the python side if the code works perfectly by instantiating the two codes and match their results.
