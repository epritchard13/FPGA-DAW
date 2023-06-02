import serial

dev = serial.Serial('COM5')

def open():
    dev.write(0x20)
    #dev.write(b'/set 5 0 1 1\n')

def get_tracks():
    cmd = b'/get\n'
    dev.write(cmd)
    s = dev.readline().decode('utf-8')

    depth = 0
    num_tracks = 0
    tracks = []
    for i in range(len(s)):
        if s[i] == '(':
            depth += 1
            if depth == 2: # new track
                num_tracks += 1
                tracks.append('')
        elif s[i] == ')':
            depth -= 1
            if depth == 2:
                tracks[num_tracks-1] += ','
        elif depth == 3:
            tracks[num_tracks-1] += s[i]

    print(tracks)
    print('Number of tracks: ' + str(num_tracks))
