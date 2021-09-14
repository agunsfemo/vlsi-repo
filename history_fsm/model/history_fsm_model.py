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
