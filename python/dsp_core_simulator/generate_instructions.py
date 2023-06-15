##################################################################################
##                                                                              ##
##                     dsp wrapper instruction compiler                         ##
##                                                                              ##
##   -generate instructions for the dsp wrapper to compute filtered sinc data   ##
##                                                                              ##
##################################################################################

EMPTIES = ['',"",' '," "]
lines,line_number = {},0

BUF_LEN = 32

memory = {"coef":{},"samp":{},"task":{}}
instructions = {}

with open("filter.strom","r")as rf:
    for line in rf:
        line = line.split("\n")[0]
        line = line.split(" ")
        good_tokens = []
        for token in line:
            if token not in EMPTIES:
                good_tokens.append(token)
        lines[line_number] = good_tokens
        line_number = line_number + 1

def parseLine(line,comeback):
    if(line == []):
        return "end"
    comeback = comeback.split(" ")
    head = line[0].split(":")
    if(len(head)>1):                        #declaration
        memory[head[0]][head[1]] = []       #initialize array
        return "PENDING "+str(head[0])+" "+str(head[1])
    elif("end" in head[0]):
        return "COMPLETE"
    else:                                   #non declaration
        if(comeback[1] != "TASK"):
            for token in line:
                memory[comeback[1]][comeback[2]].append(token.split(",")[0])
        else:
            memory[comeback[1]][comeback[2]] = line
        return "PENDING "+comeback[1]+" "+comeback[2]

def disp_data():    #display data
    print("------data------")
    for data_type in memory:
        data = memory[data_type]
        print(data_type+"s:")
        for loc in data:
            arr = data[loc]
            print("    "+loc+" "+str(len(arr)))
    print("----------------")

def disp_inst():#display instructions
    print("------inst------")
    for process in instructions:
        subprocesses = instructions[process]
        print(process+":")
        for subprocess in subprocesses:
            print("    "+subprocess+":")
            for step in subprocesses[subprocess]:
                print("        "+str(step))
    print("----------------")

def float_to_bin(structure,location):
    try:
        register = structure[location]
    except:
        register = "0000"
    return "5555"

def dereference(pointer,pointerType):
    try:
        return memory[pointerType][pointer]
    except:
        raise Exception(pointerType+" BUFFER NOT FOUND: "+pointer)

def populate_buffer(coefficients,samples):
    coefficients,samples,new_instructions = dereference(coefficients,"coef"),dereference(samples,"samp"),[]
    for i in range(BUF_LEN):    
        new_instructions.append("1 1 1 1 0 00 000 000 000 "+float_to_bin(coefficients,i)+" "+float_to_bin(samples,i))      
    return new_instructions

def shift_multiply(coefficients,samples):
    coefficients,samples,new_instructions = dereference(coefficients,"coef"),dereference(samples,"samp"),[]
    num_coef = len(coefficients)
    num_samp = len(samples)
    for k in range (num_samp):
        for i in range (num_samp):
            for j in range (num_coef):
                new_instructions.append("1 0 0 0 0 01 001 000 000 0000 0000") #circular shift coef. no shift samp. acc in 2
            new_instructions.append("1 0 1 0 0 01 111 000 000 0000 0000")#complete the circular shift. circular shift samp. acc in trash(include delay)
        new_instructions.append("1 0 1 0 1 10 111 001 000 0000 0000")#lsrc, lsls, valid to fifo, passthrough op, r1, store in output reg
    return new_instructions
    
def write_instructions():
    with open("instructions.txt", "w") as fp:
        for process in instructions:
            for subprocess in instructions[process]:
                for instruction in instructions[process][subprocess]:
                    fp.write(instruction + "\n")

#populate coefficient and sample data structures
comeback = ""
for line in lines:
    comeback = parseLine(lines[line],comeback)

for task in memory["task"]:
    task = memory["task"][task] #deref
    if(task[0] == "fir_filt"):
        instructions[task[0]] = {}
        write_to = task[1]
        instructions[task[0]]["pop_buf"] = populate_buffer(task[2],task[3]) ##populate buffer
        instructions[task[0]]["sht_mul"] = shift_multiply(task[2],task[3])




#disp_data()
write_instructions()
#print("\n")
#disp_inst()
#print("\n")








