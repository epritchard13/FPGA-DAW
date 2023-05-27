import tkinter as tk

root = tk.Tk()
root.title('DAW Control Panel')
tk.Label(root, text ="Hello World").grid(row = 0, column = 0)
tk.Button(root, text ='Button', command=root.destroy).grid(row = 1, column = 0)

c = tk.Canvas(root, height=300, width=300)
c.grid(row = 2, column = 0)
coord = 10, 50, 240, 210
c.create_rectangle(5, 5, 6, 6, fill="blue")

root.mainloop()