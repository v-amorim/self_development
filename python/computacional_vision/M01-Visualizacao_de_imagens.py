from matplotlib import pyplot as plt
import numpy as np
import cv2

img = cv2.imread('./content/julius.jpg')
plt.imshow(img)
plt.show()

RGB_im = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
plt.imshow(RGB_im)
plt.show()

plt.imshow(RGB_im[1:280, 1:280, :])
plt.show()
