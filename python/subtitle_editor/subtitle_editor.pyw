from __future__ import annotations

import sys
import tempfile
from contextlib import ExitStack
from pathlib import Path

from PyQt6 import uic
from PyQt6.QtGui import (
    QColor,
    QSyntaxHighlighter,
    QTextCharFormat,
)
from PyQt6.QtWidgets import (
    QApplication,
    QDialog,
    QFileDialog,
    QMainWindow,
    QMessageBox,
)

INITIAL_INDEX = -1


class SyntaxHighlighter(QSyntaxHighlighter):
    def __init__(self, parent):
        super().__init__(parent)
        self._highlight_lines = {}
        self._highlight_words = {}

    def highlight_line(self, line, fmt):
        if isinstance(line, int) and line >= 0 and isinstance(fmt, QTextCharFormat):
            self._highlight_lines[line] = fmt
            tb = self.document().findBlockByLineNumber(line)
            self.rehighlightBlock(tb)

    def highlight_word(self, word, fmt):
        if isinstance(word, str) and word and isinstance(fmt, QTextCharFormat):
            self._highlight_words[word] = fmt
            self.rehighlight()

    def clear_highlight(self):
        self._highlight_lines = {}
        self._highlight_words = {}
        self.rehighlight()

    def highlightBlock(self, text):  # noqa: N802
        line = self.currentBlock().blockNumber()
        fmt = self._highlight_lines.get(line)
        if fmt is not None:
            self.setFormat(0, len(text), fmt)

        for word, fmt in self._highlight_words.items():
            start_idx = text.lower().find(word.lower())
            while start_idx != -1:
                self.setFormat(start_idx, len(word), fmt)
                start_idx = text.lower().find(word.lower(), start_idx + len(word))


class IntroDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        uic.loadUi("subtitle_editor_intro.ui", self)

    def open_button_clicked(self, callback):
        self.open_button.clicked.connect(callback)


class SubtitleEditor(QMainWindow):
    def __init__(self, subtitle_path=None):
        super().__init__()
        self.subtitles = []
        self.current_subtitle_index = 0
        self.last_found_index = INITIAL_INDEX
        self.temp_file = tempfile.NamedTemporaryFile(delete=False, mode="w", encoding="utf-8")
        self.temp_file.close()

        self.init_ui()
        self.intro_dialog = IntroDialog(self)
        self.intro_dialog.open_button_clicked(self.open_file)

        if subtitle_path:
            self.load_subtitles(subtitle_path)
            self.intro_dialog.close()
        else:
            self.intro_dialog.exec()

    def init_ui(self):
        uic.loadUi("subtitle_editor_main.ui", self)

        # Connect the existing menu actions to their respective slots
        self.open_action.triggered.connect(self.open_file)
        self.save_action.triggered.connect(self.save_file)
        self.overwrite_action.triggered.connect(self.overwrite_subtitle_file)
        self.close_action.triggered.connect(self.close)

        # Connect the existing Symbols actions to their respective slots
        self.em_dash_action.triggered.connect(self.insert_em_dash)
        self.elipsis_action.triggered.connect(self.insert_elipsis)
        self.eight_note_action.triggered.connect(self.insert_eight_note)
        self.italics_action.triggered.connect(self.insert_italics)

        # Connect signals and slots
        self.subtitle_number_spinbox.valueChanged.connect(self.subtitle_number_changed)
        self.subtitle_number_spinbox.setKeyboardTracking(False)
        self.subtitle_text.textChanged.connect(self.update_subtitle_text)
        self.subtitle_text.wheelEvent = self.subtitle_text_wheel_event
        self.start_time_entry.editingFinished.connect(self.update_start_time)
        self.search_entry.returnPressed.connect(self.search_subtitle)
        self.search_entry.textChanged.connect(self.search_entry_changed)
        self.search_button.clicked.connect(self.search_subtitle)
        self.end_time_entry.editingFinished.connect(self.update_end_time)
        self.save_button.clicked.connect(self.save_file)
        self.close_button.clicked.connect(self.close)

        # Connect overwrite_button to overwrite_subtitle_file method
        self.overwrite_button.clicked.connect(self.overwrite_subtitle_file)

        # Initialize SyntaxHighlighter
        self.highlighter = SyntaxHighlighter(self.subtitle_text.document())

    def open_file(self):
        file_dialog = QFileDialog()
        file_path, _ = file_dialog.getOpenFileName(self, "Open Subtitle File", "", "Subtitle Files (*.srt *.sub)")
        if file_path:
            self.load_subtitles(file_path)
            self.intro_dialog.close()

    def load_subtitles(self, file_path):
        self.subtitles = []
        self.subtitle_path = file_path  # Store the path of the currently open subtitle file

        with Path(file_path).open(encoding="utf-8") as file:
            subtitle_lines = file.readlines()
            subtitle_data = None
            for raw_line in subtitle_lines:
                line = raw_line.strip()
                if line.isdigit():
                    if subtitle_data:
                        self.subtitles.append(subtitle_data)
                    subtitle_data = {"number": int(line), "text": ""}
                elif "-->" in line:
                    times = line.split("-->")
                    subtitle_data["start_time"] = times[0].strip()
                    subtitle_data["end_time"] = times[1].strip()
                elif line:
                    if "text" in subtitle_data:
                        subtitle_data["text"] += "\n" + line if subtitle_data["text"] else line
                    else:
                        subtitle_data["text"] = line
            if subtitle_data:
                self.subtitles.append(subtitle_data)

        if self.subtitles:
            self.subtitle_number_spinbox.setMaximum(len(self.subtitles))
            self.subtitle_number_spinbox.setSuffix(f" / {len(self.subtitles)}")
            self.current_subtitle_index = 0
            self.display_subtitle()

    def save_to_temp_file(self):
        with Path(self.temp_file.name).open("w", encoding="utf-8") as temp_file:
            for subtitle in self.subtitles:
                temp_file.write(f"{subtitle['number']}\n")
                temp_file.write(f"{subtitle['start_time']} --> {subtitle['end_time']}\n")
                temp_file.write(f"{subtitle['text']}\n\n")

    def save_file(self):
        save_path, _ = QFileDialog.getSaveFileName(self, "Save Subtitle File", "", "Subtitle Files (*.srt *.sub)")
        if save_path:
            with ExitStack() as stack:
                file = stack.enter_context(Path(save_path).open("w", encoding="utf-8"))
                temp_file = stack.enter_context(Path(self.temp_file.name).open(encoding="utf-8"))
                file.write(temp_file.read())

    def overwrite_subtitle_file(self):
        if not self.subtitles:
            QMessageBox.warning(self, "No Subtitles", "There are no subtitles loaded to overwrite.")
            return

        if not self.temp_file.name:
            QMessageBox.warning(self, "Temporary File Issue", "Temporary file not created properly.")
            return

        save_path = self.temp_file.name  # Use the temporary file for overwriting

        # Ensure the user wants to overwrite the file
        reply = QMessageBox.question(
            self,
            "Confirm Overwrite",
            "Are you sure you want to overwrite the subtitle file?",
            QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No,
        )
        if reply == QMessageBox.StandardButton.No:
            return

        # Write subtitles to the temporary file
        self.save_to_temp_file()

        # Copy the temporary file contents to the original subtitle file
        with ExitStack() as stack:
            temp_file = stack.enter_context(Path(save_path).open("r", encoding="utf-8"))
            original_file = stack.enter_context(Path(self.subtitle_path).open("w", encoding="utf-8"))
            original_file.write(temp_file.read())

        QMessageBox.information(self, "Overwrite Complete", "Subtitle file has been successfully overwritten.")

    def display_subtitle(self):
        if 0 <= self.current_subtitle_index < len(self.subtitles):
            subtitle = self.subtitles[self.current_subtitle_index]
            self.subtitle_number_spinbox.setValue(subtitle["number"])
            self.subtitle_text.setPlainText(subtitle["text"])
            self.start_time_entry.setText(subtitle["start_time"])
            self.end_time_entry.setText(subtitle["end_time"])
            self.highlight_search_term()

    def subtitle_number_changed(self):
        desired_subtitle_number = self.subtitle_number_spinbox.value()
        for index, subtitle in enumerate(self.subtitles):
            if subtitle["number"] == desired_subtitle_number:
                self.current_subtitle_index = index
                self.display_subtitle()
                return
        QMessageBox.information(self, "Subtitle Not Found", f"Subtitle {desired_subtitle_number} not found.")

    def search_subtitle(self):
        search_text = self.search_entry.text().lower()
        if not search_text:
            QMessageBox.warning(self, "Empty Search", "Please enter text to search.")
            return

        found_index = INITIAL_INDEX
        for index in range(self.last_found_index + 1, len(self.subtitles)):
            if search_text in self.subtitles[index]["text"].lower():
                found_index = index
                break

        if found_index != INITIAL_INDEX:
            self.current_subtitle_index = found_index
            self.display_subtitle()
            self.last_found_index = found_index
        else:
            QMessageBox.information(self, "Subtitle Not Found", f"No more subtitles contain the text '{search_text}'.")
            self.last_found_index = INITIAL_INDEX

    def highlight_search_term(self):
        if search_text := self.search_entry.text().lower():
            fmt = QTextCharFormat()
            fmt.setBackground(QColor("#0078d4"))
            self.highlighter.clear_highlight()
            self.highlighter.highlight_word(search_text, fmt)

    def search_entry_changed(self):
        if not self.search_entry.text():
            self.clear_highlight()

    def clear_highlight(self):
        self.highlighter.clear_highlight()
        self.subtitle_text.setPlainText(self.subtitle_text.toPlainText())

    def update_subtitle_text(self):
        if 0 <= self.current_subtitle_index < len(self.subtitles):
            self.subtitles[self.current_subtitle_index]["text"] = self.subtitle_text.toPlainText()
            self.save_to_temp_file()

    def update_start_time(self):
        if 0 <= self.current_subtitle_index < len(self.subtitles):
            self.subtitles[self.current_subtitle_index]["start_time"] = self.start_time_entry.text()
            self.save_to_temp_file()

    def update_end_time(self):
        if 0 <= self.current_subtitle_index < len(self.subtitles):
            self.subtitles[self.current_subtitle_index]["end_time"] = self.end_time_entry.text()
            self.save_to_temp_file()

    def subtitle_text_wheel_event(self, event):
        delta = event.angleDelta().y()
        if delta > 0:
            self.current_subtitle_index = max(0, self.current_subtitle_index + 1)
        elif delta < 0:
            self.current_subtitle_index = min(len(self.subtitles) - 1, self.current_subtitle_index - 1)
        self.display_subtitle()
        event.accept()

    def insert_em_dash(self):
        self.subtitle_text.insertPlainText("— ")

    def insert_elipsis(self):
        self.subtitle_text.insertPlainText("…")

    def insert_eight_note(self):
        self.wrap_selected_text("♪ ", " ♪")

    def insert_italics(self):
        self.wrap_selected_text("<i>", "</i>")

    def wrap_selected_text(self, start_char, end_char):
        cursor = self.subtitle_text.textCursor()
        selected_text = cursor.selectedText()
        wrapped_text = f"{start_char}{selected_text}{end_char}"
        cursor.insertText(wrapped_text)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    subtitle_path = sys.argv[1] if len(sys.argv) > 1 else None
    subtitle_editor = SubtitleEditor(subtitle_path)
    subtitle_editor.show()
    sys.exit(app.exec())
