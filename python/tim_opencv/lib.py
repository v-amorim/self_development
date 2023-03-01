import cv2
import matplotlib.pyplot as plt

COLOR_BGR2GRAY = cv2.COLOR_BGR2GRAY


def show_image(image, title=None, conversion=cv2.COLOR_BGR2RGB, figsize=(4, 3)):
    image = cv2.cvtColor(image, conversion)
    plt.rcParams["figure.figsize"] = figsize

    plt.imshow(image, cmap='gray') if conversion == COLOR_BGR2GRAY else plt.imshow(image)

    plt.xticks([])
    plt.yticks([])

    if title is not None:
        plt.title(f'{title}\n{image.shape}')
