from __future__ import annotations

import pygame
pygame.init()
font = pygame.font.Font(None, 30)


def debug(info, y=10, x=10):
    """
    Display debug info on the screen.

    Parameters
    ----------
    info : str
        The debug info to be displayed.
    y : int
        The y coordinate of the debug info.
    x : int
        The x coordinate of the debug info.

    """
    display_surface = pygame.display.get_surface()
    debug_surf = font.render(str(info), True, 'White')
    debug_rect = debug_surf.get_rect(topleft=(x, y))
    pygame.draw.rect(display_surface, 'Black', debug_rect)
    display_surface.blit(debug_surf, debug_rect)
