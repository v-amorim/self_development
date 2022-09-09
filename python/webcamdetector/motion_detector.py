import cv2
import pyautogui
from datetime import datetime
from winsound import Beep

first_frame = None
status_list = [None, None]
time_list = []
video = cv2.VideoCapture(0)

while True:
    check, frame = video.read()
    status = 0

    gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    gray_frame = cv2.GaussianBlur(gray_frame, (21, 21), 0)
    # gray_frame = cv2.flip(gray_frame, 1)

    if first_frame is None:
        first_frame = gray_frame
        continue

    delta_frame = cv2.absdiff(first_frame, gray_frame)

    threshold_frame = cv2.threshold(delta_frame, 30, 255, cv2.THRESH_BINARY)[1]
    threshold_frame = cv2.dilate(threshold_frame, None, iterations=2)

    (cnts, _) = cv2.findContours(threshold_frame.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    for contour in cnts:
        if cv2.contourArea(contour) < 20000:
            continue
        status = 1
        (x, y, w, h) = cv2.boundingRect(contour)
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 3)

    status_list.append(status)

    if status_list[-1] == 1 and status_list[-2] == 0:
        time_list.append(datetime.now())
        # Beep(440, 250)
        pyautogui.hotkey('winleft', '2')
    if status_list[-1] == 0 and status_list[-2] == 1:
        time_list.append(datetime.now())
        Beep(4400, 250)

    # cv2.imshow("Gray Frame", gray_frame)
    # cv2.imshow("Delta Frame", delta_frame)
    # cv2.imshow("Threshold Frame", threshold_frame)
    cv2.imshow("Color Frame", frame)

    key = cv2.waitKey(1)

    if key == ord('q'):
        if status == 1:
            time_list.append(datetime.now())
        break

# print(status_list)
# print(time_list)

video.release()
cv2.destroyAllWindows()
