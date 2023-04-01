from __future__ import annotations

import pygame
import settings as s
from debug import debug
from player import Player
from tile import Tile


class Level():
    def __init__(self):
        # get display surface
        self.display_surface = pygame.display.get_surface()
        # sprite group setup
        self.visible_sprites = pygame.sprite.Group()
        self.obstable_sprites = pygame.sprite.Group()
        self.create_map()

    def create_map(self):
        for row_index, row in enumerate(s.WORLD_MAP):
            for column_index, col in enumerate(row):
                x = column_index * s.TILE_SIZE
                y = row_index * s.TILE_SIZE
                if col in s.OBSTABLE_TILES:
                    Tile((x, y), [self.visible_sprites, self.obstable_sprites])
                elif col == s.PLAYER_TILE:
                    self.player = Player((x, y), [self.visible_sprites], self.obstable_sprites)

    def run(self):
        self.visible_sprites.draw(self.display_surface)
        self.visible_sprites.update()
        debug(self.player.direction)
