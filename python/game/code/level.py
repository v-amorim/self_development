from __future__ import annotations

import os

import pygame
import settings as s
from player import Player
from support import import_csv_layout
from tile import Tile
# from debug import debug

GROUND = 'ground.png'
GROUND_ASSET = os.path.join(s.TILEMAP_PATH, GROUND)

BOUNDARY_MAP = 'map_FloorBlocks.csv'
BOUNDARY_MAP_ASSET = os.path.join(s.MAP_PATH, BOUNDARY_MAP)


class Level():
    def __init__(self):
        # get display surface
        self.display_surface = pygame.display.get_surface()
        # sprite group setup
        self.visible_sprites = YSortCameraGroup()
        self.obstable_sprites = pygame.sprite.Group()
        self.create_map()

    def create_map(self):
        layouts = {
            'boundary': import_csv_layout(BOUNDARY_MAP_ASSET),
        }
        for style, layout in layouts.items():
            for row_index, row in enumerate(layout):
                for column_index, col in enumerate(row):
                    if col != '-1':
                        x = column_index * s.TILE_SIZE
                        y = row_index * s.TILE_SIZE

                        if style == 'boundary':
                            Tile(
                                pos=(x, y),
                                groups=[self.obstable_sprites],
                                sprite_type='invisible'
                            )

        #         if col in s.OBSTABLE_TILES:
        #             Tile((x, y), [self.visible_sprites, self.obstable_sprites])
        #         elif col == s.PLAYER_TILE:
        #             self.player = Player((x, y), [self.visible_sprites], self.obstable_sprites)
        self.player = Player((2000, 1430), [self.visible_sprites], self.obstable_sprites)

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

        self.floor_surf = pygame.image.load(GROUND_ASSET).convert()
        self.floor_rect = self.floor_surf.get_rect(topleft=(0, 0))

    def custom_draw(self, player: Player):
        self.offset.x = self.half_width - player.rect.centerx
        self.offset.y = self.half_height - player.rect.centery

        floor_offset_pos = self.offset - self.floor_rect.topleft
        self.display_surface.blit(self.floor_surf, floor_offset_pos)

        for sprite in sorted(self.sprites(), key=lambda sprite: sprite.rect.centery):
            offset_position = sprite.rect.topleft + self.offset
            self.display_surface.blit(sprite.image, offset_position)
