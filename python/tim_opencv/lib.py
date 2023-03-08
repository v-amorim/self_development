import cv2
import numpy as np
import matplotlib.pyplot as plt

COLOR_BGR2GRAY = cv2.COLOR_BGR2GRAY
FILLER_IMG = [np.ones((3, 3, 3), dtype=np.uint8) * 255]


def create_plot(num_images, figsize):
    num_cols = min(3, num_images)
    num_rows = (num_images + num_cols - 1) // num_cols
    figsize = figsize or (num_cols * 5, num_rows * 5)
    fig, axes = plt.subplots(num_rows, num_cols, figsize=figsize)
    axes = np.ravel(axes)
    return fig, axes


def add_image_to_plot(ax, img, is_grayscale=False, title=None):
    cmap = 'gray' if is_grayscale else None
    ax.imshow(img.astype('uint8'), cmap=cmap)
    if title:
        ax.set_title(title)
    ax.axis('off')


def show_single_image(image, figsize=(10, 10)):
    plt.rcParams["figure.figsize"] = figsize

    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) if len(image.shape) == 3 else image
    plt.imshow(image, cmap='gray') if len(image.shape) == 2 else plt.imshow(image)
    plt.title(f'{image.shape}')

    plt.xticks([])
    plt.yticks([])

    plt.show()


def show_images(images, figsize=None):
    if len(images) > 100:
        show_single_image(images, figsize)
        return

    fig, axes = create_plot(len(images), figsize)
    for i, image in enumerate(images):
        _2param = len(image) > 2
        _1param = len(image) > 1
        img = cv2.imread(image[0]) if isinstance(image[0], str) else image[0]
        conversion = image[2] if _2param else image[1] if _1param and type(image[1]) == int else cv2.COLOR_BGR2RGB

        if conversion is not None and len(img.shape) == 3:
            img = cv2.cvtColor(img, conversion)

        is_grayscale = conversion == cv2.COLOR_BGR2GRAY or len(img.shape) == 2
        title = image[1] if _1param and type(image[1]) == str else None

        add_image_to_plot(axes.flat[i], img, is_grayscale=is_grayscale, title=title)

    if len(images) < len(axes):
        for i in range(len(images), len(axes)):
            axes.flat[i].axis('off')

    plt.tight_layout()
    plt.show()
