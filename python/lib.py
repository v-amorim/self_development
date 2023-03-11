import time
from typing import List, Optional, Tuple, Union

import cv2
import matplotlib.pyplot as plt
import numpy as np

COLOR_BGR2GRAY = cv2.COLOR_BGR2GRAY
FILLER_IMG = [np.ones((3, 3, 3), dtype=np.uint8) * 255]


def create_plot(num_images: int, figsize: Optional[Tuple[int, int]]) -> Tuple[plt.Figure, np.ndarray]:
    num_cols = min(3, num_images)
    num_rows = (num_images + num_cols - 1) // num_cols
    figsize = figsize or (num_cols * 5, num_rows * 5)
    fig, axes = plt.subplots(num_rows, num_cols, figsize=figsize)
    axes = np.ravel(axes)
    return fig, axes


def add_image_to_plot(ax: plt.Axes, img: np.ndarray, is_grayscale: bool = False, title: Optional[str] = None) -> None:
    cmap = 'gray' if is_grayscale else None
    ax.imshow(img.astype('uint8'), cmap=cmap)
    if title:
        ax.set_title(title)
    ax.axis('off')


def show_single_image(image: np.ndarray, figsize: Tuple[int, int] = (10, 10)) -> None:
    plt.figure(figsize=figsize)

    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) if len(image.shape) == 3 else image
    plt.imshow(image, cmap='gray') if len(image.shape) == 2 else plt.imshow(image)
    plt.title(f'{image.shape}')

    plt.xticks([])
    plt.yticks([])

    plt.show()


def show_images(images: Union[np.ndarray, List[Union[np.ndarray, List[Union[str, int]]]]],
                figsize: Union[None, Tuple[int, int]] = None) -> None:
    if type(images) == np.ndarray:
        show_single_image(images, figsize)
        return
    else:
        images = [images] if type(images[0]) != list else images

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


def show_video(video: Optional[Union[Tuple[str, str], List[str]]] = None,
               frame_width: Optional[int] = None,
               frame_height: Optional[int] = None) -> None:
    if video is not None:
        video_path = video[0]
        video_title = video[1]
    else:
        video_path = 0
        video_title = 'Video'

    cap = cv2.VideoCapture(video_path)
    fps = int(cap.get(cv2.CAP_PROP_FPS))

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        time.sleep(1 / fps)

        if frame_width is not None and frame_height is not None:
            frame = cv2.resize(frame, (frame_width, frame_height))

        cv2.imshow(video_title, frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()
