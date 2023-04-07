from __future__ import annotations

import os

import tcod
from actions import EscapeAction
from actions import MovementAction
from input_handlers import EventHandler

SCRIPT_DIR = os.path.abspath(os.path.dirname(__file__))
DATA_FOLDER = os.path.join(SCRIPT_DIR, 'data')
FONT_FILE = os.path.join(DATA_FOLDER, 'dejavu10x10_gs_tc.png')


def main() -> None:
    screen_width = 80
    screen_height = 50
    player_x = screen_width // 2
    player_y = screen_height // 2

    tileset = tcod.tileset.load_tilesheet(FONT_FILE, 32, 8, tcod.tileset.CHARMAP_TCOD)

    event_handler = EventHandler()

    with tcod.context.new_terminal(
        screen_width,
        screen_height,
        tileset=tileset,
        title='Yet Another Roguelike Tutorial',
        vsync=True,
    ) as context:
        root_console = tcod.Console(screen_width, screen_height, order='F')
        while True:
            root_console.print(x=player_x, y=player_y, string='@')

            context.present(root_console)

            for event in tcod.event.wait():
                action = event_handler.dispatch(event)

                if action is None:
                    continue

                if isinstance(action, MovementAction):
                    player_x += action.dx
                    player_y += action.dy

                elif isinstance(action, EscapeAction):
                    raise SystemExit()


if __name__ == '__main__':
    main()
