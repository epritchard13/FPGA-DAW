EMPTIES = ['',"",' '," "]
COMMENT = ['//',"//"]
types = ["double","int"]
lines,line_number = {},0
constants = {}
variables = {}
functions = {}

######################################################
####################  DEPRICATED  ####################
###########  SEE GENERATE_INSTRUCTIONS.PY  ###########
######################################################



#tokenize
with open("filter.strom" , "r") as rf:
    for line in rf:
        line = line.split("\n")[0]
        line = line.split(" ")
        good_tokens = []
        for token in line:
            if token not in EMPTIES:
                good_tokens.append(token)
        lines[line_number] = good_tokens
        line_number = line_number + 1


var_type = ""
def parseLine(line,comeback):
    if(line == []):
        return "empty"
    #if(len(comeback.split(":"))>1):
        #print(str(line)+" number of remaining: "+comeback.split(":")[2])
    if(line[0] == "#define"):       #define a constant
        line.pop(0)
        constants[line[0]] = line[1]
        return "completed"
    if(line[0] == "double"):        #instantiate a double
        var_type = line[0]
        line.pop(0)
        array = False
        if(len(line[0].split("[")) > 1):        #when [ is attached to name token
            name = line[0].split("[")[0]
            array = True
        elif(";" in line[0]):
            name = line[0].split(";")[0]
        line.pop(0)
        if(line[0].isdigit()):
            size = line[0]
        else:
            try:
                size = constants[line[0]]
            except:
                print("unknown size")
        line.pop(0)
        if(line[0] == "]"):
            line.pop(0)
            if(line[0] == "="):
                variables[name] = {}
                variables[name]["type"] = var_type
                variables[name]["size"] = size
                variables[name]["data"] = []
                if(array):
                    if(len(line) == 1):
                        return "pending definition of:"+name+":"+size
        else:   #not array
            variables[name] = {}
            variables[name]["type"] = var_type
            variables[name]["size"] = 1
            variables[name]["data"] = []
            line.pop(0)
            if(len(line)==0):
                return "complete"

    if(line[0]=="void"):                #a new function
        line.pop(0)
        if(len(line[0].split("("))>1):      #when ( is attached to name token)
            name = line[0].split("(")[0]
            line.pop(0)
            try:
                attempt = functions[name]   #does it exist?
            except:
                functions[name] = {}
                functions[name]["parameters"] = {}
            while(len(line)>0):
                if(line[0] in types):
                    parameter_type = line[0]
                    line.pop(0)
                    if(")" in line[0]):
                        return "completed"
                    else:
                        functions[name]["parameters"][line[0]] = parameter_type
                        line.pop(0)
            return "pending parameters of:"+name+":"+"?"
            
               
    
    if(line[0] == "{"):         #finish instantiation of double
        comeback,name,size = comeback.split(":")
        if(comeback=="pending definition of"):
            if(len(line)==1):
                return comeback+":"+name+":"+size
        elif(comeback=="pending implementation of"):
            return "pending implementation of:"+name+":?"
    if(line[0] == "};"):
        comeback,name,size = comeback.split(":")
        if(comeback=="pending definition of"):
            return "completed"
    else:                       #probably data
        if(len(comeback.split(":"))>1):
            comeback,name,size = comeback.split(":")
            if(comeback=="pending definition of"):
                if(int(size) > 0):
                    number_of_definitions = len(line)
                    for i in range(number_of_definitions):
                        variables[name]["data"].append(line[0])
                        line.pop(0)
                    if(len(line)==0):
                        return comeback+":"+name+":"+str(int(size)-number_of_definitions)
            elif(comeback=="pending parameters of"):
                while(len(line)>0):
                    if(line[0] in types):
                        parameter_type = line[0]
                        line.pop(0)
                        if(")" in line[0]):
                            functions[name]["parameters"][line[0].split(")")[0]] = parameter_type
                            line.pop(0)
                            return "pending implementation of:"+name+":?"
                        else:
                            functions[name]["parameters"][line[0]] = parameter_type
                            line.pop(0)
                    elif(")" in line[0]):
                        return "pending implementation of:"+name+":?"
                return "pending parameters of:"+name+":?"


def fail():
    print("PARSE ERROR LINE " + expection_message)
    print("\n")
    print("----------------variables----------------")
    print(variables)
    print("\n")
    print("----------------constants----------------")
    print(constants)
    print("\n")
    print("----------------functions----------------")
    print(functions)
    print("\n")
    raise Exception ("parser entered unknown state")
    


#parse tokens
comeback = ""
exception = False
expection_message = ""
for line in lines:
    comeback = parseLine(lines[line],comeback)
    if(comeback == None):
        expection_message = str(line+1)+": "+str(lines[line])
        exception = True
        fail()
        




