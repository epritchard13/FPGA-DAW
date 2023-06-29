SAMP_BIT_WIDT = 16
COEF_BIT_WIDT = 16
ACCU_BIT_WIDT = 32
ACCU_REG_QUAN = 8
SAMP_BUF_SIZE = 8
COEF_BUF_SIZE = 8
memory = {}
widths = {"samp_buffer": SAMP_BIT_WIDT, "coef_buffer":COEF_BIT_WIDT, "accu_regist":ACCU_BIT_WIDT}
quants = {"samp_buffer": SAMP_BUF_SIZE, "coef_buffer":COEF_BUF_SIZE, "accu_regist":ACCU_REG_QUAN}

def array_to_string(array):
    builder = ""
    for item in array:
        builder = builder + item + " "
    return builder 



def shift_buffer(buffer):
    shifted = array_to_string(memory[buffer])[widths[buffer]+1:(quants[buffer]+1)*(widths[buffer])] + array_to_string(memory[buffer])[0:widths[buffer]+1]
    memory[buffer] = shifted.split(" ")[0:len(shifted.split(" "))-1]


def dsp(samp,coef,accu):
    return accu + (samp*coef)

def inst():
    memory["samp_buffer"] = ["0" * SAMP_BIT_WIDT] * SAMP_BUF_SIZE
    memory["coef_buffer"] = ["0" * COEF_BIT_WIDT] * COEF_BUF_SIZE
    memory["accu_regist"] = ["0" * ACCU_BIT_WIDT] * ACCU_REG_QUAN

def parse_inst(inst,state):
    coef_new, coef_circ, samp_new, samp_circ, outp_val, operation, acD, acS, samp, coef = inst.split(" ")
    if(coef_new == "1"):
        shift_buffer("coef_buffer")
        if(coef_circ == "1"):
            memory["coef_buffer"][COEF_BUF_SIZE-1] = coef
    if(samp_new == "1"):
        shift_buffer("samp_buffer")
        if(samp_circ == "1"):
            memory["samp_buffer"][SAMP_BUF_SIZE-1] = samp
            

    print(memory)
            
    
    

state = inst()
with open("instructions2.txt","r") as fp:
    for line in fp:
        line = line.split("\n")[0]
        state = parse_inst(line,state)


