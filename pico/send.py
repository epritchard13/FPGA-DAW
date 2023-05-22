import serial
import time
import os
import math

ser = serial.Serial('COM5')

a = 0
size = 500

def clamp(val, min_val, max_val):
    return min(max_val, max(min_val, val))

packet = bytearray()
#for i in range(100000):
#    packet.append(0x20)

ser.write(packet)
for k in range(100):
    # write the byte of i
    # write /audio <size> 
    #read the response
    #print(ser.readline(), end='')
    packet = bytearray()
    packet.append(0x53)
    #append size as a little-endian 4 byte integer
    packet.append(size & 0xFF)
    packet.append((size >> 8) & 0xFF)
    packet.append((size >> 16) & 0xFF)
    packet.append((size >> 24) & 0xFF)

    #print(ser.readline(), end='')
    for i in range(size):
        val = int(127.5 + 127.5 * math.sin(a / 20))
        val = clamp(val, 0, 255)
        if val != 0x88 and val != 0x87:
            packet.append(val)
        else:
            packet.append(0x89)
        a += 1
    #for i in range(100):
    #   packet.append(0x30)
    ser.write(packet)
    

