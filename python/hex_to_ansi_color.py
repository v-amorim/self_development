from __future__ import annotations

import numpy as np


class TruecolorConverter:
    RESET_COLOR = "\033[0m"

    def __init__(self):
        self.ansi_palette = self._generate_ansi_palette()

    @staticmethod
    def hex_to_ansi_color(hex_color: str, *, background: bool = False) -> str:
        """Convert a hex color code to an ANSI escape code for Truecolor (24-bit RGB)."""
        hex_color = hex_color.lstrip("#")
        r, g, b = (int(hex_color[i: i + 2], 16) for i in (0, 2, 4))
        return f"\033[48;2;{r};{g};{b}m" if background else f"\033[38;2;{r};{g};{b}m"

    def show_ansi255_colors(self, *, hex_format: bool = True, background: bool = False) -> None:
        """Display a range of ANSI 256 colors in a grid format with an ID."""
        color_type = "Background" if background else "Foreground"
        print(f"{color_type} Colors:")

        num_colors_per_row = 16
        for color_id in range(256):
            ansi_code = f"\033[{('48' if background else '38')};5;{color_id}m"
            closest_color_hex = self.ansi_palette[color_id]
            hex_color_str = f"#{closest_color_hex[0]:02x}{closest_color_hex[1]:02x}{closest_color_hex[2]:02x}"
            output_format = f" {hex_color_str}" if hex_format else repr(ansi_code)
            print(f"{ansi_code} {output_format} {self.RESET_COLOR}", end=" ")

            if (color_id + 1) % num_colors_per_row == 0:
                print()
        print()

    def ansi_repr(self, ansi_code: str) -> str:
        """Return a string representation of the ANSI escape code with modifications."""
        return repr(ansi_code).replace(r"'\x1b", "`e")[:-1]

    def get_color(self, hex_color: str) -> tuple[str, str]:
        fg_ansi_code = self.hex_to_ansi_color(hex_color, background=False)
        bg_ansi_code = self.hex_to_ansi_color(hex_color, background=True)
        return self.color_print_formatter(fg_ansi_code, hex_color, bg_ansi_code, " RGB ANSI Color         : ")

    def _generate_ansi_palette(self) -> np.ndarray:
        """Generate the RGB values for the 256-color ANSI palette."""
        basic_colors = self._basic_colors()
        cube_colors = self._cube_colors()
        grayscale_colors = self._grayscale_colors()
        return np.vstack([basic_colors, cube_colors, grayscale_colors])

    def get_closest_ansi_color(self, hex_color: str) -> int:
        """Find the closest 256-color ANSI code to the given hex color."""
        target_color = self._hex_to_rgb_array(hex_color)
        distances = np.linalg.norm(self.ansi_palette - target_color, axis=1)
        return np.argmin(distances)

    def print_closest_ansi_color(self, hex_color: str) -> tuple[str, str]:
        """Print and return the closest ANSI color code and its representation."""
        fg_ansi_code, _ = self.get_color(hex_color)
        closest_index = self.get_closest_ansi_color(hex_color)
        fg_ansi_code = f"\033[38;5;{closest_index}m"
        bg_ansi_code = f"\033[48;5;{closest_index}m"
        return self.color_print_formatter(
            fg_ansi_code, hex_color, bg_ansi_code, f" Closest ANSI 256 Color [{closest_index}]: "
        )

    def color_print_formatter(self, fg_ansi_code, hex_color, bg_ansi_code, color_message):
        output = (
            f"[{fg_ansi_code}{hex_color}{self.RESET_COLOR}]"
            f"[{bg_ansi_code}{hex_color}{self.RESET_COLOR}]"
            f"{color_message}{self.ansi_repr(fg_ansi_code)}"
        )
        print(output)
        return fg_ansi_code, bg_ansi_code

    @staticmethod
    def _hex_to_rgb_array(hex_color: str) -> np.ndarray:
        """Convert a hex color code to an RGB numpy array."""
        hex_color = hex_color.lstrip("#")
        return np.array([int(hex_color[i: i + 2], 16) for i in (0, 2, 4)])

    @staticmethod
    def _basic_colors() -> np.ndarray:
        """Return an array of the 16 basic ANSI colors."""
        return np.array(
            [
                [0, 0, 0],
                [205, 0, 0],
                [0, 205, 0],
                [205, 205, 0],
                [0, 0, 205],
                [205, 0, 205],
                [0, 255, 255],
                [229, 229, 229],
                [127, 127, 127],
                [255, 0, 0],
                [0, 255, 0],
                [255, 255, 0],
                [0, 0, 255],
                [255, 0, 255],
                [0, 255, 255],
                [255, 255, 255],
            ]
        )

    @staticmethod
    def _cube_colors() -> np.ndarray:
        """Return an array of the 216 colors in a 6x6x6 color cube."""
        return np.array(
            [[r, g, b] for r in np.linspace(0, 255, 6) for g in np.linspace(0, 255, 6) for b in np.linspace(0, 255, 6)]
        )

    @staticmethod
    def _grayscale_colors() -> np.ndarray:
        """Return an array of the 24 grayscale colors."""
        return np.array([[i, i, i] for i in np.linspace(8, 238, 24)])


# Example usage:
converter = TruecolorConverter()
converter.show_ansi255_colors(background=True)
converter.show_ansi255_colors(background=False)
converter.get_color("#F69BDC")
converter.print_closest_ansi_color("#F69BDC")
