# Ripple Carry Full Adder

## Introduction to Full Adder
The full adder operation takes in three single bit binary **a**, **b**, **c_in** and the output of the full adder operation is given by **sum** and  **c_out** where **sum = a ^ b ^ c_in**, and **c_out = (a & b)  + (a & c_in) + b & c_in)**. Note that the **^** symbol represents XOR operation. 

## Ripple Carry Adder
A ripple carry adder is a logic circuit in which the carry-out of each full adder is the carry in of the succeeding next most significant full adder. It is called a ripple carry adder because each carry bit gets rippled into the next stage.

In this example, a gate level boolean masking approach was used to for the computation of each single bit input **a**, and **b**. This was done by combining 2 shares of the inputs with an **XOR** gate. 

This example aims at showcasing boolean masked full-adder as follows
