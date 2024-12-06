# main.py
import cv2
import numpy as np
import pyautogui
from matcher import Matcher

# Load the template and the target image (the screen capture)
template = cv2.imread("template.png", cv2.IMREAD_COLOR)
screen = pyautogui.screenshot()
screen = np.array(screen)
screen = cv2.cvtColor(screen, cv2.COLOR_RGB2BGR)

# Initialize the matcher
matcher = Matcher()

# Find the matches for the template in the target image (screen)
matches = matcher.match_template(template, screen, matching_threshold=0.7)

# If matches are found, move the mouse to the center of the first match and click
if matches:
    # Take the first match (you could handle multiple matches if needed)
    match = matches[0]
    x, y, w, h = match
    center_x = x
    center_y = y

    # Move the mouse to the center of the match
    pyautogui.moveTo(center_x, center_y, duration=0.5)

    # Click the center of the match
    pyautogui.click(center_x, center_y)

    print(f"Found match at {center_x}, {center_y} and clicked it.")
else:
    print("No match found.")
