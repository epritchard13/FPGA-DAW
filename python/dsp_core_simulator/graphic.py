import os
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