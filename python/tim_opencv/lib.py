import cv2
import matplotlib.pyplot as plt

COLOR_BGR2GRAY = cv2.COLOR_BGR2GRAY


def show_image(image, title=None, conversion=cv2.COLOR_BGR2RGB, figsize=(4, 3)):
    image = cv2.cvtColor(image, conversion)
    plt.figure(figsize=figsize)

    plt.imshow(image, cmap='gray') if conversion == COLOR_BGR2GRAY else plt.imshow(image)

    plt.xticks([])
    plt.yticks([])

    if title is not None:
        plt.title(f'{title}\n{image.shape}')


def show_images(images, titles=None, conversion=cv2.COLOR_BGR2RGB, figsize=(15, 6), rows=1, columns=1):
    plt.figure(figsize=figsize)
    for i, image in enumerate(images):
        image = cv2.cvtColor(image, conversion)
        plt.subplot(rows, columns, i + 1)
        plt.imshow(image, cmap='gray') if conversion == COLOR_BGR2GRAY else plt.imshow(image)
        plt.xticks([])
        plt.yticks([])

        if titles is not None:
            plt.title(f'{titles[i]} {image.shape}')

    plt.show()
