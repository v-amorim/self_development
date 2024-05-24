from __future__ import annotations

import ctypes
import subprocess
import sys
from datetime import datetime

import requests


def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except OSError:
        return False


def get_brasilia_time():
    api_url = "http://worldtimeapi.org/api/timezone/America/Sao_Paulo"
    response = requests.get(api_url)
    data = response.json()
    date_str = data["datetime"][:10]
    date_str = datetime.strptime(date_str, "%Y-%m-%d").strftime("%d-%m-%y")
    time_str = data["datetime"][11:19]
    return date_str, time_str


def send_to_admin_cmd(command):
    subprocess.run(command, shell=True)


if is_admin():
    # Get Brasilia time
    brasilia_date, brasilia_time = get_brasilia_time()

    # Form the command to be executed in the admin CMD
    cmd_display = f"echo Date: {brasilia_date} && echo Time: {brasilia_time}"
    cmd_set = f"date {brasilia_date} && time {brasilia_time}"
    cmd_command = f"{cmd_display} && {cmd_set}"

    # Send the command to the admin CMD
    send_to_admin_cmd(cmd_command)
else:
    # Re-run the script with admin privileges
    ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
