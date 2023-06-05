import tkinter as tk
import daw
import json

canvas_width = 800
canvas_height = 400
mem_window_height = 100

def draw():
    top = daw.get_json()
    playhead = top['head_pos']
    tracks = top['tracks']
    num_tracks = len(tracks)
    track_height = canvas_height / num_tracks

    # clear canvas
    window.delete("all")
    window.create_rectangle(0, 0, canvas_width, canvas_height, fill="gray", outline="gray")
    
    # draw tracks
    for i in range(num_tracks):
        # draw line dividers
        window.create_line(0, (i+1)*track_height, canvas_width, (i+1)*track_height, fill="black")
        clips = tracks[i]['clips']
        for clip in clips:
            start = clip['timestamp']
            end = start + clip['size']
            window.create_rectangle(start, i*track_height, end, (i+1)*track_height, fill="green", outline="blue")

    # draw playhead
    window.create_line(playhead, 0, playhead, canvas_height, fill="red", width=5)

    # draw memory
    mem_window.delete("all")
    mem_window.create_rectangle(0, 0, canvas_width, mem_window_height, fill="gray", outline="gray")

    max_blocks = top['num_mem_blocks']
    blocks = top['mem_blocks']
    num_blocks = len(blocks)
    blocks.sort()

    #draw black box if block is not in blocks, else draw green box
    i2 = 0
    for i in range(max_blocks):
        if i2 < num_blocks and blocks[i2] == i:
            mem_window.create_rectangle(i * canvas_width / max_blocks, 0, (i+1) * canvas_width / max_blocks, mem_window_height, fill="green", outline="black")
            i2 += 1
        else:
            mem_window.create_rectangle(i * canvas_width / max_blocks, 0, (i+1) * canvas_width / max_blocks, mem_window_height, fill="black", outline="black")


def runsm():
    daw.runsm()
    draw()

def pop(): 
    daw.pop()
    draw()

root = tk.Tk()
root.title('DAW Control Panel')

a = tk.Button(root, text='Refresh', command=draw)#.grid(row=0, column=0)
b = tk.Button(root, text='Run', command=runsm)#.grid(row=0, column=1)
c = tk.Button(root, text='Pop', command=pop)#.grid(row=0, column=1)

# create canvas and draw background
window = tk.Canvas(root, height=canvas_height, width=canvas_width)
mem_window = tk.Canvas(root, height=mem_window_height, width=canvas_width)
#c.grid(row=2, column=0)

daw.open()
daw.init_tracks()

a.pack()
b.pack()
c.pack()
window.pack()
mem_window.pack()
root.mainloop()
