# Importação das bibliotecas
from __future__ import annotations

import cv2
from matplotlib import pyplot as plt

img_lena_jpg = cv2.imread('./content/lena.jpg')
RGB_im_lena_jpg = cv2.cvtColor(img_lena_jpg, cv2.COLOR_BGR2RGB)

img_lena_png = cv2.imread('./content/lena.png', cv2.IMREAD_UNCHANGED)
RGB_im_lena_png = cv2.cvtColor(img_lena_png, cv2.COLOR_BGR2RGB)


fig = plt.figure(figsize=(7, 7))

plt.subplots_adjust(left=0.125, bottom=0.1, right=1.5, top=1,
                    wspace=0.33, hspace=0.2)

x1_plt = fig.add_subplot(1, 3, 1)
x2_plt = fig.add_subplot(1, 3, 2)


x1_plt.set_title('Formato JPG 512x512')
x1_plt.imshow(RGB_im_lena_jpg)
x2_plt.set_title('Formato PNG')
x2_plt.imshow(RGB_im_lena_png)

plt.show()
