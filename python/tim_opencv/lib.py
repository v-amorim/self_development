import cv2
import matplotlib.pyplot as plt

COLOR_BGR2GRAY = cv2.COLOR_BGR2GRAY


def show_image(image):
    img = cv2.imread(image[0])
    color_conversion = image[2] if len(image) > 2 else cv2.COLOR_BGR2RGB
    img = cv2.cvtColor(img, color_conversion) if len(image) > 2 else img

    if len(image) > 2 and image[2] == COLOR_BGR2GRAY:
        plt.imshow(img, cmap='gray')
    else:
        plt.imshow(img)

    plt.title(image[1])
    plt.axis('off')

    plt.tight_layout()
    plt.show()


def show_images(images):
    num_images = len(images)
    num_cols = min(3, num_images)
    num_rows = (num_images + num_cols - 1) // num_cols
    figsize = (num_cols * 5, num_rows * 5)

    fig, axes = plt.subplots(num_rows, num_cols, figsize=figsize)
    axes = axes.flatten()

    for i in range(num_images):
        img = cv2.imread(images[i][0])
        color_conversion = images[i][2] if len(images[i]) > 2 else cv2.COLOR_BGR2RGB
        img = cv2.cvtColor(img, color_conversion) if len(images[i]) > 2 else img

        if len(images[i]) > 2 and images[i][2] == COLOR_BGR2GRAY:
            axes[i].imshow(img, cmap='gray')
        else:
            axes[i].imshow(img)

        axes[i].set_title(images[i][1])
        axes[i].axis('off')

    for i in range(num_images, num_rows * num_cols):
        fig.delaxes(axes[i])

    plt.tight_layout()
    plt.show()
