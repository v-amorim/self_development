import cv2
import matplotlib.pyplot as plt


def show_rgb_image(image, title=None, conversion=cv2.COLOR_BGR2RGB):
    image = cv2.cvtColor(image, conversion)
    plt.rcParams["figure.figsize"] = [4, 3]
    plt.imshow(image)

    plt.xticks([])
    plt.yticks([])

    if title is not None:
        plt.title(title)

    plt.show()
