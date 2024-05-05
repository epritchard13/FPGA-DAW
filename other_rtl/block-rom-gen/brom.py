# generate a sine lookup table of length 512

import math

f = open('sine.txt', 'w')

for i in range(0, 512, 2):
    num = int(127 * math.sin(2 * math.pi * (i + 1) / 512) + 127)
    num = num << 8
    num = num | int(127 * math.sin(2 * math.pi * (i + 0) / 512) + 127)
    f.write("%d: data <= 16'h%X;\n" % (i / 2, num))

f.close()