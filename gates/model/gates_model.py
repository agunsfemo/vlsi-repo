def gates(a, b):
    yand = a and b
    yor = a or b
    yxor = ((not a) and b) or (a and (not b))
    ynand = not (a and b)
    ynor = not (a or b)
    yxnor = not (((not a) and b) or (a and (not b)))
    return  yand, yor, yxor, ynand, ynor, yxnor

