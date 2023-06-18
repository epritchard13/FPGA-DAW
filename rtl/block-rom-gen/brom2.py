# generate a sine lookup table of length 512

import math

f = open('sine.txt', 'w')

for i in range(0, 512, 2):
    num = int((i + 1) % 256)
    num = num << 8
    num = num | int(i % 256)
    f.write("%d: data <= 16'h%X;\n" % (i / 2, num))

f.close()