import serial
import time
import os
import math
import wave
import matplotlib.pyplot as plt
import numpy as np

with wave.open('recipe.wav') as fd:
    params = fd.getparams()
    frames = fd.readframes(1000000000)

audio = np.ndarray(len(frames) // 4, dtype=np.uint8)
print(len(frames), audio.shape)
for i in range(audio.shape[0]):
    audio[i] = (frames[i * 4 + 1] + 128) % 256

# write audio as binary file
with open('recipe.raw', 'wb') as fd:
    fd.write(audio.tobytes())

exit()

ser = serial.Serial('COM5')

size = 1024

def clamp(val, min_val, max_val):
    return min(max_val, max(min_val, val))


packet = bytearray()
#for i in range(100000):
#    packet.append(0x20)

index = 0
ser.write(packet)
while index < audio.shape[0]:
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
        val = audio[index]
        index += 1
        if (index >= audio.shape[0]):
            exit()

        val = clamp(val, 0, 255)
        packet.append(val)
    ser.write(packet)
