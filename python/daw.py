import serial
import json

dev = serial.Serial('COM5')

def open():
    dev.write(0x20)
    #dev.write(b'/set 5 0 1 1\n')

def init_tracks():
    dev.write(b'/clear\n')
    dev.write(b'/move 100')
    for i in range(8):
        dev.write(b'/add\n')
        cmd = '/set '
        cmd += str(i)
        cmd += ' 0 ' + str(i * 50) + ' 200\n'
        dev.write(cmd.encode('utf-8'))
    # add a second track to 3
    cmd = '/set 1 0 600 50\n'
    dev.write(cmd.encode('utf-8'))


def runsm():
    dev.write(b'/runsm\n')

def pop():
    dev.read_all()
    dev.write(b'/pop\n')
    print(dev.readline().decode('utf-8'))

def get_json():
    dev.write(b'/json\n')
    s = dev.readline().decode('utf-8')
    return json.loads(s)


def get_memory():
    dev.write(b'/memory\n')
    s = dev.readline().decode('utf-8').split(' ')
    num_blocks = int(s[0])
    s = s[1:]
    blocks = []
    for i in range(num_blocks):
        try:
            blocks.append(int(s[i]))
        except:
            pass
    return (num_blocks, blocks)

def get_tracks():
    cmd = b'/get\n'
    dev.write(cmd)
    s = dev.readline().decode('utf-8')
    #print("Received:", s)

    depth = 0
    num_tracks = 0
    tracks = []
    playhead = 0
    for i in range(len(s)):
        if s[i] == '(':
            depth += 1
            if depth == 1: # playhead
                tmp = s[i+1:]
                playhead = int(tmp[:tmp.find(',')])
            if depth == 2: # new track
                num_tracks += 1
                tracks.append('')
        elif s[i] == ')':
            depth -= 1
            if depth == 2: # next track
                tracks[num_tracks-1] += ','
        elif depth >= 3:
            tracks[num_tracks-1] += s[i]

    #print(tracks)
    # parse tracks
    for i in range(num_tracks):
        tracks[i] = tracks[i].split(',')[:-1]

        list = []
        for j in range(len(tracks[i])):
            if j % 5 == 0:
                track = []
                list.append(track)
            if (j % 5 < 4):
                track.append(int(tracks[i][j]))
        tracks[i] = list

    #print(tracks)
    return (playhead, tracks)
