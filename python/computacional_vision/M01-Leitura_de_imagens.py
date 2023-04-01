from __future__ import annotations

import cv2
img = cv2.imread('./content/logo.png', cv2.IMREAD_UNCHANGED)
cv2.imshow('image', img)

img[0:1000, 0:1000, 0] = 0
img[0:1000, 0:100, 1] = 0
img[0:1000, 0:1000, 2] = 0
cv2.imshow('image', img)
cv2.waitKey(0)
cv2.destroyAllWindows()
cv2.waitKey(1)
