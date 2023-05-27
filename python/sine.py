import serial
import time
import os
import math

ser = serial.Serial('COM5')

a = 0
size = 1000

def clamp(val, min_val, max_val):
    return min(max_val, max(min_val, val))

while(1):
    packet = bytearray()
    packet.append(0x53)
    #append size as a little-endian 4 byte integer
    packet.append(size & 0xFF)
    packet.append((size >> 8) & 0xFF)
    packet.append((size >> 16) & 0xFF)
    packet.append((size >> 24) & 0xFF)

    #print(ser.readline(), end='')
    for i in range(size):
        val = int(127.5 + 127.5 * math.sin(a / 100))
        val = clamp(val, 0, 255)
        packet.append(val)
        a += 1
    #for i in range(100):
    #   packet.append(0x30)
    ser.write(packet)
    

