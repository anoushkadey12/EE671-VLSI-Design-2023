import random
num_test=10

with open("testcases.txt",'w') as t:
    for i in range(num_test):
        Cin=random.randint(0,1)
        A=random.randint(0,4294967296)
        B=random.randint(0,4294967296)
        S=A+B+Cin
        if S<=4294967296:
            Cout=0
        else:
            Cout=1
        S= S&0xFFFFFFFF
        line=str(Cin)+str("{0:b}".format(A).zfill(32))+str("{0:b}".format(B).zfill(32)) + " " + str(Cout) + str("{0:b}".format(S).zfill(32))
        t.write(line+'\n')






