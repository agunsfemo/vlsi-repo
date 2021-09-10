def full_adder_a34(a, b, c_in):
    sum = a ^ (b ^ c_in)
    c_out = (a & b) | ((a ^ b) & c_in)
    return sum, c_out
