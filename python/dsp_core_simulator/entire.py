#instantiate pico sim
import pico_sim as pico

#simulate transfer fifos


#instantiate dsp cores
#import wrapper

NUM_DSP_BLOCKS = 1

#instantiate graphic
import graphic

graphic.REFRESH_DELAY = .1
screen_state = graphic.create()
clock = False
box = graphic.text_to_image(graphic.create_box(20,10))
message = graphic.text_to_image("hello:")

#while(True):
#    screen_state = graphic.render(clock,box,screen_state,20,20)
#    screen_state = graphic.render(clock,message,screen_state,22,22)
#    print(graphic.strings(screen_state))
#    screen_state = graphic.create()
#    graphic.wait()
#    clock = not clock

#read samples from files, write samples to file (simulate user input / output)
curr_effex_data = {} #coefficient and organization data from filters    
curr_audio_ptrs = {} #audio data contained in each track
curr_torun_comm = [] #command data. will return to len 0 when commands have been run. commands are typically user actions which require calculations
with open("user_input.txt", "r") as fp:
    for new_user_input in fp:
        new_user_input = new_user_input.split("\n")
        curr_effex_data, curr_audio_ptrs, curr_torun_comm = pico.update_state(new_user_input, curr_effex_data, curr_audio_ptrs, curr_torun_comm)
        coefficients = pico.generate_coefficients(curr_effex_data)
        audio_data = pico.read_from_psram(curr_audio_ptrs)
