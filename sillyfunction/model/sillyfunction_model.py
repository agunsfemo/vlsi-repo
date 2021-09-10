def sillyfunction(a, b, c):
    return (not a and not b and not c) \
           or (a and not b and not c) \
               or (a and not b and c)
