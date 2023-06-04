import tkinter as tk
import daw

canvas_width = 800
canvas_height = 400

def draw():
    tracks = daw.get_tracks()
    num_tracks = len(tracks)
    track_height = canvas_height / num_tracks

    # clear canvas
    c.delete("all")
    c.create_rectangle(0, 0, canvas_width, canvas_height, fill="gray", outline="gray")

    # draw tracks
    for i in range(num_tracks):
        # draw line dividers
        c.create_line(0, (i+1)*track_height, canvas_width, (i+1)*track_height, fill="black")
        for clip in tracks[i]:
            c.create_rectangle(clip[1], i*track_height, clip[1] + clip[2], (i+1)*track_height, fill="green", outline="blue")


root = tk.Tk()
root.title('DAW Control Panel')
tk.Button(root, text='Refresh', command=draw).grid(row=1, column=0)

# create canvas and draw background
c = tk.Canvas(root, height=canvas_height, width=canvas_width)
c.grid(row=2, column=0)
background = c.create_rectangle(0, 0, canvas_width, canvas_height, fill="gray", outline="gray")

daw.open()
daw.init_tracks()

root.mainloop()
