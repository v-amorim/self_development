import cv2
import numpy as np
import matplotlib.pyplot as plt

COLOR_BGR2GRAY = cv2.COLOR_BGR2GRAY
FILLER_IMG = [np.ones((3, 3, 3), dtype=np.uint8) * 255]


def show_image(image, ispath=True):
    if ispath:
        img = cv2.imread(image[0])
        color_conversion = image[2] if len(image) > 2 else cv2.COLOR_BGR2RGB
        img = cv2.cvtColor(img, color_conversion) if len(image) > 2 else img
    else:
        img = image[0]
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    if len(image) > 2 and image[2] == COLOR_BGR2GRAY:
        plt.imshow(img, cmap='gray')
    else:
        plt.imshow(img)

    if len(image) > 1 and image[1]:
        plt.title(image[1])

    plt.axis('off')

    plt.tight_layout()
    plt.show()


def show_images(images, ispath=True):
    num_images = len(images)
    num_cols = min(3, num_images)
    num_rows = (num_images + num_cols - 1) // num_cols
    figsize = (num_cols * 5, num_rows * 5)

    fig, axes = plt.subplots(num_rows, num_cols, figsize=figsize)
    axes = axes.flatten()

    for i in range(num_images):
        if ispath:
            img = cv2.imread(images[i][0])
            color_conversion = images[i][2] if len(images[i]) > 2 else cv2.COLOR_BGR2RGB
            img = cv2.cvtColor(img, color_conversion) if len(images[i]) > 2 else img
        else:
            img = images[i][0]
            img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

        if len(images[i]) > 2 and images[i][2] == COLOR_BGR2GRAY:
            axes[i].imshow(img, cmap='gray')
        else:
            axes[i].imshow(img)

        if len(images[i]) > 1 and images[i][1]:
            axes[i].set_title(images[i][1])
        axes[i].axis('off')

    for i in range(num_images, num_rows * num_cols):
        fig.delaxes(axes[i])

    plt.tight_layout()
    plt.show()
