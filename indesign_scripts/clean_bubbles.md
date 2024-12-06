# Usage

I think this is the fastest way to clean the bubble text once you have a levelled image. It makes use of the "QuickWand" tool and the "Make Work Path" feature. Sorry for lack of help images, but this is basic.

1. Use QuickWand with options: tolerance set high (128), contiguous, anti-alias, Sample All Layers

2. Click white space in each bubble. (If any of the selection "leaks out" into the image, the bubble border is broken, so just undo the last quick wand, find the break, patch it with a brush, and (ctrl-shift-d) reselect what you have already.)

3. You can double check none of the bubbles are "leaking", by going to Channels, pushing Q (quick mask mode) and making "Grey" channel invisible. Then you will see a simple black/white mask of the bubbles. If everything is ok, hit Q again and exit quickmask mode.

4. Execute "Make work path", TOLERANCE = 0.5. If you're not familiar with this command, you can find it by: if quick wand tool is the active tool, just right click on the canvas, and it will be in the context menu; or you can find it from the Paths window if you click on its option menu.

5. Make all layers invisible so you can see the paths clearly.

6. Switch to Pen tool (P). Hold CTRL+SHIFT keys down and then select all the bubble border paths (and not the text) (this is what makes this method fast); don't do this by clicking on each border, just drag a small box over the border so you select some part of the border.

7. Once all the paths of the bubble borders are selected, right click on the canvas, and from the context menu choose "Make selection"

8. From the menu, Select->Modify->Contract (either 1 or 2 pixels), to preserve the smooth bubble border

9. Then switch to Marquee Tool (M), right click on canvas to select from the context menu "Fill...", Use WHITE, everything else normal.

10. Deselect (ctrl+d), and delete the work path that was created. You are done.
