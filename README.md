Conway's Game of Life
=====================

This is a simple implementation of Conway's Game of Life.

<img src="https://dl.dropboxusercontent.com/u/18596008/Screenshot%202015-03-04%2001.16.13.png"/>

Features
--------
- Pause simulation
- Edit grid while simulation is running
- Control length of intervals between generations
- Generate random grids
- Show populations/neighbors of each cell
- Grid wrapping

I have features planned for the future such as:

- Resizable window
- Grid that resizes with the window
- Generate popular patterns (Acorn, Glider Gun, etc.)
- Infinite grid with zooming
- Support for other cellular automata (That might be just a whole 'nother program by then)

Controls
--------
- L-click/R-click = create/erase cells
- Mouse Scroll or Arrow Keys = adjust interval length
- Space = Pause
- S = Step
- H = Toggle Help/Info
- C = Clear Grid*
- R = Generate Random Grid*
- P = Toggle Population**
- G = Toggle Gridlines**
- W = Toggle Wrapping 

\*resets counter

\*\*affects performance

Building
--------
This program was written with LÖVE. You can download LÖVE at [their website](http://love2d.org/).

Information on building LÖVE executables for Windows, OSX, and Linux can be found [here](https://love2d.org/wiki/Game_Distribution).

TL;DR for lazy Windows users like me:
```
> copy /b love.exe+gameoflife.love gameoflife.exe
```

Downloads
---------
Completed builds can be downloaded [from here](https://www.dropbox.com/sh/kxlg449iq5f4xoa/AADF_AxOTZiY-t4OX8wAdzIwa?dl=0). Note at this time, only Windows builds are available.

The current version is **0.3.0**.

License
-------
Copyright (c) 2015 Jeremias A. Dulaca II

This program is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />The icon included is licensed under the <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.
