import os
from pydoc import plain
import time

WIDTH,HEIGHT  = os.get_terminal_size()
REFRESH_DELAY = 0.5
FLASHERS = [":"]

def wait():
    time.sleep(REFRESH_DELAY)

def create():
    screen_state = []               #create the screen buffer
    for line in range(HEIGHT):
        screen_state.append([])
        for character in range(WIDTH):
            screen_state[line].append(" ")
    return screen_state

def strings(screen_state):
    screen = ""
    for line in screen_state:
        builder = ""
        for character in line:
            builder = builder + character
        screen = screen + builder
    return screen

def create_box(x_size,y_size):
    if((x_size > 2) and (y_size > 2)):
        across = ""
        across_blank = ""
        for i in range(x_size-2):
            across = across + "-"
            across_blank = across_blank + " "
        text_rep = " " + across + "\n"
        for i in range(y_size-2):
            text_rep = text_rep + "|" + across_blank + "|\n"
        text_rep = text_rep + " " + across
        return text_rep

def text_to_image(text):
    text = text.split("\n")
    image_array = []
    for line in text:
        line_array = []
        for char in line:
            line_array.append(char)
        image_array.append(line_array)
    return image_array

def array_average(array):
    sum = 0
    for item in array:
        sum = sum + item
    return int(sum / len(array))

def array_to_plot(array,height,length):
    builder,counter,samp_count = {},1,1
    placement_array = []
    for i in range(height):
        builder[i] = []
        placement_array.append([])
        for j in range(length):
            placement_array[i].append("")


    print(builder)

    for item in array:
        adjusted_height = int(float(item) / height)     #bin the input data (y axis)
        builder[counter].append(adjusted_height)
        if(samp_count / counter == length):             #x axis binner
            counter = counter + 1
        samp_count = samp_count + 1
    counter = 1
    for bin in builder:
        placement_array[counter][array_average(builder[bin])] = "."
        counter = counter + 1
    return placement_array
        



def render(clock,image,screen_state,x_offset,y_offset):
    for i in range(HEIGHT):
        if((i >= y_offset) and (i < y_offset + len(image))):
            for j in range(WIDTH):
                if((j >= x_offset) and (j < x_offset + len(image[i-y_offset]))):
                    character = image[i-y_offset][j-x_offset]
                    if(clock):
                        if(character in FLASHERS):
                            character = " "
                    screen_state[i][j] = character
    return screen_state