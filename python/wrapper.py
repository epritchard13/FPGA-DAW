##################################################################################
##                                                                              ##
##                          dsp wrapper simulator                               ##
##                                                                              ##
##     -execute commands for the dsp wrapper to computer filtered sinc data     ##
##                                                                              ##
##################################################################################

BUF_LEN = 2
HEX_WID = 4
ACC_NUM = 8

#simulate the dsp core
def dsp(a,b,c,d):
    temp = b
    if(len(b)>3):
        b = b[1:4]
    
    p = hex((int(a,16)*int(b,16))+int(c,16)+int(d,16))
    p = p[2:len(p)]#remove "0x"
    for i in range((HEX_WID*2) - len(p)):
        p = "0"+p
    if(len(p)==8):
        return p
    elif(len(p)==9):
        return p[1:9]

#convert operation to opcode
def luo(op):
    if(op == "00"):
        return "nop"
    elif(op == "01"):
        return "dsp"
    elif(op == "10"):
        return "na"
    elif(op == "11"):
        return "na"

#manage input buffer
def shift(index,new,memory,co):
    unpack = memory[index].split(",")[1:BUF_LEN+1]#lose the comma.
    delay = unpack[0]
    unpack.pop(0)
    if(co=="11"):
        unpack.append(new)    
    elif(co == "10"):
        unpack.append(memory[index+"d"])   
    builder = ""
    for i in range(BUF_LEN):
        builder = builder + "," + str(unpack[i])
    memory[index] = builder
    memory[index+"d"] = str(delay)
    return memory

#execute an operation
def rtl(memory,ac2,ac1,ac0,op,v):
    A,B,OUT,OP = int(ac1,2),int(ac0,2),int(ac2,2),op
    if(OP != "dsp"):
        return memory
    elif(OP == "dsp"):
        unpack = memory["accu"].split(",")[1:ACC_NUM+1]
        unpack[OUT] = dsp(memory["samp"].split(",")[1][0:HEX_WID],memory["coef"].split(",")[1][0:HEX_WID],memory["accu"].split(",")[A+1][0:HEX_WID*2],memory["accu"].split(",")[B+1][0:HEX_WID*2])
        #print("op: acc_"+str(OUT)+"    <=    "+unpack[OUT]+" = "+"(samp: "+str(memory["samp"].split(",")[1][0:HEX_WID])+" * coef: "+str(memory["coef"].split(",")[1][0:HEX_WID])+") + "+"acc_"+str(A)+"("+memory["accu"].split(",")[A+1][0:HEX_WID*2]+") + acc_"+str(B)+"("+memory["accu"].split(",")[B+1][0:HEX_WID*2]+")")
        
        builder = ""
        for i in range(ACC_NUM):
            builder = builder + "," + str(unpack[i])
        memory["accu"] = builder

    return memory

#parse an instruction
def parse(next_coef,next_samp,memory,instruction): #shift_coef, new_coef, shift_samp, new_samp, out_valid, operation[2], dest_acc[3], sA_acc[3], sB_acc[3]
    c,o,s,a,v,op,ac2,ac1,ac0 = instruction.split(" ")
    if(c == "1"):
        memory = shift("coef",next_coef,memory,c+o)
    if(s == "1"):
        memory = shift("samp",next_samp,memory,s+a)

    memory = rtl(memory,ac2,ac1,ac0,luo(op),v)

    return memory


#initialize memory
def init():
    memory, word, accs = {"coef":"","coefd":"","samp":"","sampd":"","accu":""}, "", ""
    for i in range(HEX_WID):
        word = word + "0"
    memory["coefd"] = word
    memory["sampd"] = word
    for i in range(BUF_LEN):
        memory["coef"] = memory["coef"] + "," + word
        memory["samp"] = memory["samp"] + "," + word
    for i in range(HEX_WID):#accumulator width is twice 
        accs = accs + "0"
    for i in range(ACC_NUM):
        memory["accu"] = memory["accu"] + "," + word + word
    return memory

#execute instructions
with open("instructions.txt", "r") as fp:
    memory = init()
    for line in fp:
        if((line[0] == "1") or (line[0]=="0")):
            line = line.split("\n")[0].split(" ")
            instruction = line[0]+" "+line[1]+" "+line[2]+" "+line[3]+" "+line[4]+" "+line[5]+" "+line[6]+" "+line[7]+" "+line[8]
            memory = parse(line[9],line[10],memory,instruction)
            print(memory)



