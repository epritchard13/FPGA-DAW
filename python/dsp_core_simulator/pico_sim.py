#drive qui

#read gui
#def parse_manual_input():
    

#drive psram / samples

#drive sd

#drive instructions

#drive coef

#manage adc ctrl, mixer, vol (scraps)



#user can trigger audio to be played from a certain timestamp, add new tracks, new fx, change values and so on
#returns updated pointers and commands depending on the user input.
def update_state(new_user_input, curr_effex_data, curr_audio_ptrs,curr_torun_comm):
    #parse_manual_input(new_user_input, curr_effex_data, curr_audio_ptrs, curr_torun_comm)
    return curr_effex_data, curr_audio_ptrs, curr_torun_comm

def generate_coefficients(curr_effex_data):
    return {}

def read_from_psram(curr_audio_ptrs):
    return {}
