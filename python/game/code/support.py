from __future__ import annotations

from csv import reader


def import_csv_layout(path):
    terrain_map = []
    with open(path) as level_map:
        layout = reader(level_map, delimiter=',')
        terrain_map.extend(list(row) for row in layout)
    return terrain_map
