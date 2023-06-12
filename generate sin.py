import math
BIT_WIDTH = 16
FREQUENCY = 10

with open("sin.txt", "w") as fp:
    for i in range(2**BIT_WIDTH):
        fp.write(str(int(2**BIT_WIDTH * math.sin(FREQUENCY * i/(2**16))))+"\n")


