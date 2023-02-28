import numpy as np
import cv2


def camera_function1(frame):
    cv2.imshow('Video', frame)


def camera_function2(frame):
    image = np.zeros(frame.shape, np.uint8)
    height = frame.shape[0]
    width = frame.shape[1]

    smaller_frame = cv2.resize(frame, (0, 0), fx=0.5, fy=0.5)
    image[:height // 2, :width // 2] = smaller_frame
    image[:height // 2, width // 2:] = cv2.flip(smaller_frame, 1)

    image[height // 2:, :width // 2] = cv2.flip(smaller_frame, 0)
    image[height // 2:, width // 2:] = cv2.flip(smaller_frame, -1)

    cv2.imshow('Video', image)


if __name__ == '__main__':
    camera = cv2.VideoCapture(0)

    while True:
        _, frame = camera.read()
        # camera_function1(frame)
        camera_function2(frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    camera.release()
    cv2.destroyAllWindows()
