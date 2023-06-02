import tkinter as tk
import daw

canvas_width = 800
canvas_height = 400

root = tk.Tk()
root.title('DAW Control Panel')
#tk.Label(root, text="Hello World").grid(row=0, column=0)
#tk.Button(root, text='Button', command=root.destroy).grid(row=1, column=0)

# create canvas and draw background
c = tk.Canvas(root, height=canvas_height, width=canvas_width)
c.grid(row=2, column=0)
background = c.create_rectangle(0, 0, canvas_width, canvas_height, fill="gray", outline="gray")

daw.open()
daw.get_tracks()

root.mainloop()
