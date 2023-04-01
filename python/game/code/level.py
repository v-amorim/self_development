from __future__ import annotations

import pygame
import settings as s
from player import Player
from tile import Tile
# from debug import debug


class Level():
    def __init__(self):
        # get display surface
        self.display_surface = pygame.display.get_surface()
        # sprite group setup
        self.visible_sprites = YSortCameraGroup()
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
        self.visible_sprites.custom_draw(self.player)
        self.visible_sprites.update()


class YSortCameraGroup(pygame.sprite.Group):
    def __init__(self):
        super().__init__()
        self.display_surface = pygame.display.get_surface()
        self.half_width = self.display_surface.get_size()[0] // 2
        self.half_height = self.display_surface.get_size()[1] // 2
        self.offset = pygame.math.Vector2(100, 200)

    def custom_draw(self, player: Player):
        self.offset.x = self.half_width - player.rect.centerx
        self.offset.y = self.half_height - player.rect.centery

        for sprite in self.sprites():
            offset_position = sprite.rect.topleft + self.offset
            self.display_surface.blit(sprite.image, offset_position)
