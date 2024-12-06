from datetime import datetime
from typing import Optional
from winsound import Beep

import cv2
import pyautogui

# Constants
CONTOUR_AREA_LIMIT = 20000
THRESHOLD_VALUE = 30
DILATION_ITERATIONS = 2
CAMERA_INDEX = 0
BEEP_FREQUENCY_START = 4400
BEEP_DURATION = 250
HOTKEY_COMBO = ("winleft", "2")


def process_frame(frame, first_frame: Optional[cv2.Mat]) -> tuple[cv2.Mat, int]:
    gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gray_frame = cv2.GaussianBlur(gray_frame, (21, 21), 0)

    if first_frame is None:
        return gray_frame, 0

    delta_frame = cv2.absdiff(first_frame, gray_frame)
    threshold_frame = cv2.threshold(delta_frame, THRESHOLD_VALUE, 255, cv2.THRESH_BINARY)[1]
    threshold_frame = cv2.dilate(threshold_frame, None, iterations=DILATION_ITERATIONS)

    contours, _ = cv2.findContours(
        threshold_frame.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE
    )

    motion_detected = any(cv2.contourArea(contour) >= CONTOUR_AREA_LIMIT for contour in contours)
    return gray_frame, int(motion_detected)


def main():
    video = cv2.VideoCapture(CAMERA_INDEX)
    if not video.isOpened():
        raise RuntimeError("Unable to access the camera.")

    first_frame = None
    status_list = [None, None]
    time_list = []

    while True:
        check, frame = video.read()
        if not check:
            break

        first_frame, status = process_frame(frame, first_frame)
        status_list.append(status)

        if status_list[-1] == 1 and status_list[-2] == 0:
            time_list.append(datetime.now())
            pyautogui.hotkey(*HOTKEY_COMBO)
        elif status_list[-1] == 0 and status_list[-2] == 1:
            time_list.append(datetime.now())
            Beep(BEEP_FREQUENCY_START, BEEP_DURATION)

        cv2.imshow("Motion Detection", frame)
        if cv2.waitKey(1) == ord("q"):
            if status == 1:
                time_list.append(datetime.now())
            break

    video.release()
    cv2.destroyAllWindows()


if __name__ == "__main__":
    main()
