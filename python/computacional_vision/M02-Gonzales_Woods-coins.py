# Importação das bibliotecas
from __future__ import annotations

import cv2
from matplotlib import pyplot as plt

# lendo a imagem BGR
f1 = plt.figure(1).canvas.set_window_title('Imagem BGR')
plt.title('Imagem BGR')
img = cv2.imread('./content/coins.jpg')
plt.imshow(img)

# convertendo para RGB
f2 = plt.figure(2).canvas.set_window_title('Imagem BGR')
plt.title('Imagem RGB')
imgrgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
plt.imshow(imgrgb)
# plt.show()


print(f'Largura em pixels: {img.shape[1]}')
print(f'Altura em pixels: {img.shape[0]}')
print(f'Qtde de canais: {img.shape[2]}')


f3 = plt.figure(3).canvas.set_window_title('Imagem com alteração no Briho e contraste')
plt.title('Imagem com alteração no Briho e contraste')
alpha = 1.5  # Controle de contraste (0.0 - 3.0)
beta = 53    # Controle de brilho (0 - 100)
new_img = cv2.convertScaleAbs(imgrgb, alpha=alpha, beta=beta)
plt.imshow(new_img)
# plt.show()

b, g, r = cv2.split(new_img)
f4 = plt.figure(4).canvas.set_window_title('Canal Blue')
plt.title('Canal Blue')
plt.imshow(b)
f5 = plt.figure(5).canvas.set_window_title('Canal Green')
plt.title('Canal Green')
plt.imshow(g)
f6 = plt.figure(6).canvas.set_window_title('Canal Red')
plt.title('Canal Red')
plt.imshow(r)
# plt.show()

f7 = plt.figure(7).canvas.set_window_title('Mapa Red')
plt.title('Mapa Red')
r = img.copy()
r = r[:, :, 0]
plt.imshow(r, cmap='Reds_r')
f8 = plt.figure(8).canvas.set_window_title('Mapa Green')
plt.title('Mapa Green')
g = img.copy()
g = g[:, :, 1]
plt.imshow(g, cmap='Greens_r')
f9 = plt.figure(9).canvas.set_window_title('Mapa Blue')
plt.title('Mapa Blue')
b = img.copy()
b = b[:, :, 2]
plt.imshow(b, cmap='Blues_r')

plt.show()
