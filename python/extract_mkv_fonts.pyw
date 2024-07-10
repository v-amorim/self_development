# Original Idea from https://gist.github.com/FichteFoll/4488489

import configparser
import re
import subprocess
import tkinter as tk
from collections import namedtuple
from pathlib import Path
from tkinter import filedialog, messagebox


class ConfigHandler:
    CONFIG_FILE = "config.ini"

    def __init__(self):
        self.config = configparser.ConfigParser()
        self.mkvtoolnix_path = ""

        if not Path(self.CONFIG_FILE).exists():
            self._create_config()
        else:
            self._load_config()

    def _create_config(self):
        self.config["DEFAULT"] = {"mkvtoolnix_path": ""}
        with Path(self.CONFIG_FILE).open("w") as configfile:
            self.config.write(configfile)

    def _load_config(self):
        self.config.read(self.CONFIG_FILE)
        self.mkvtoolnix_path = self.config["DEFAULT"].get("mkvtoolnix_path", "")

    def save_config(self, mkvtoolnix_path):
        self.config["DEFAULT"]["mkvtoolnix_path"] = mkvtoolnix_path
        with Path(self.CONFIG_FILE).open("w") as configfile:
            self.config.write(configfile)
        self.mkvtoolnix_path = mkvtoolnix_path


class MKVExtractor:
    attachment_types = ("application/x-truetype-font", "application/vnd.ms-opentype")
    print_debug = False

    def __init__(self, video_path, mkvtoolnix_path):
        self.video_path = video_path
        self.mkvtoolnix_path = mkvtoolnix_path
        self.output_folder = Path(video_path).parent / Path(video_path).stem
        self._ensure_output_folder()
        self.container = self._identify_container()

    def _ensure_output_folder(self):
        if not Path(self.output_folder).exists():
            Path(self.output_folder).mkdir(parents=True)

    def _run_mkv(self, tool, *params):
        cmd = (
            Path(self.mkvtoolnix_path) / f"mkv{tool}.exe",
            "--ui-language",
            "en",
            *params,
        )
        return subprocess.check_output(cmd, universal_newlines=True)

    @classmethod
    def _debug(cls, *args):
        if cls.print_debug:
            print(*args)

    def _identify_container(self):
        identify = self._run_mkv("merge", "--identify", self.video_path)
        self._debug(identify)

        MatroskaContainer = namedtuple("MatroskaContainer", "tracks attachments")
        Track = namedtuple("Track", "id type codec")
        Attachment = namedtuple("Attachment", "id type size name")

        regexp_track = re.compile(r"^Track ID (?P<id>\d+): (?P<type>\w+) \((?P<codec>[^\)]+)\)$", re.MULTILINE)
        regexp_attachment = re.compile(
            r"^Attachment ID (?P<id>\d+): type '(?P<type>[^']+)', "
            r"size (?P<size>\d+) bytes, file name '(?P<name>[^']+)'$",
            re.MULTILINE,
        )

        def collect(regex, container):
            return [container(*match.groups()) for match in regex.finditer(identify)]

        return MatroskaContainer(collect(regexp_track, Track), collect(regexp_attachment, Attachment))

    def extract_attachments(self):
        attachments = self.container.attachments
        print(f"Found {len(attachments)} attachments for {self.video_path}")

        count = 0
        for attach in attachments:
            if self._should_extract(attach):
                self._extract_attachment(attach)
                count += 1

        print(f"Extracted {count} fonts.")
        messagebox.showinfo("Extraction Complete", f"Extracted {count} fonts.")

    def _should_extract(self, attach):
        def match_extension(name):
            return re.search("\\.(ttf|otf|ass)$", name, re.IGNORECASE)

        extension_matches = match_extension(attach.name)
        type_matches = attach.type in self.attachment_types

        if not extension_matches and not type_matches:
            print(f"Skipping '{attach.name}' ({attach.id})...")
            return False
        if (self.output_folder / attach.name).exists():
            print(f"'{attach.name}' ({attach.id}) already exists, skipping...")
            return False
        if not extension_matches:
            print(f"Type mismatch but extension of a font; still extracting... ('{attach.name}', {attach.type})")
        if not type_matches:
            print(f"Extension mismatch but type of a font; still extracting... ('{attach.name}', {attach.type})")

        return True

    def _extract_attachment(self, attach):
        try:
            self._debug(
                self._run_mkv(
                    "extract",
                    "attachments",
                    self.video_path,
                    f"{attach.id}:{Path(self.output_folder) / attach.name}",
                )
            )
            print(f"Extracting '{attach.name}'...")
        except subprocess.CalledProcessError as e:
            print(e)


class MKVExtractorGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("MKV Font Extractor")

        self.config_handler = ConfigHandler()
        self._ensure_mkvtoolnix_path()

        self.label = tk.Label(root, text="Select a Matroska video file:")
        self.label.pack(pady=10)

        self.select_button = tk.Button(root, text="Select File", command=self.select_file)
        self.select_button.pack(pady=5)

        self.extract_button = tk.Button(root, text="Extract Fonts", command=self.extract_fonts, state=tk.DISABLED)
        self.extract_button.pack(pady=5)

        self.video_path = ""

    def _ensure_mkvtoolnix_path(self):
        if not self.config_handler.mkvtoolnix_path or not self._verify_mkvtoolnix_path(
            self.config_handler.mkvtoolnix_path
        ):
            self._prompt_mkvtoolnix_path()

    def _prompt_mkvtoolnix_path(self):
        while True:
            path = filedialog.askdirectory(title="Select MKVToolNix Directory")

            if path and self._verify_mkvtoolnix_path(path):
                self.config_handler.save_config(path)
                break

            messagebox.showerror(
                "Error",
                "Invalid MKVToolNix path. Please select the correct directory.",
            )

    def _verify_mkvtoolnix_path(self, path):
        required_files = ["mkvmerge.exe", "mkvextract.exe"]
        return all((Path(path) / file).is_file() for file in required_files)

    def select_file(self):
        self.video_path = filedialog.askopenfilename(filetypes=[("Matroska Video Files", "*.mkv")])
        if self.video_path:
            self.extract_button.config(state=tk.NORMAL)

    def extract_fonts(self):
        if not self.video_path:
            messagebox.showerror("Error", "Please select a video file first.")
            return

        extractor = MKVExtractor(self.video_path, self.config_handler.mkvtoolnix_path)
        extractor.extract_attachments()


def main():
    root = tk.Tk()
    MKVExtractorGUI(root)
    root.mainloop()


if __name__ == "__main__":
    main()
