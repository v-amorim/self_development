import pygame
import sys
import settings as s
from level import Level
# from debug import debug


class Game:
    def __init__(self):

        # general setup
        pygame.init()
        self.screen = pygame.display.set_mode((s.WIDTH, s.HEIGTH))
        pygame.display.set_caption(s.GAME_TITLE)
        self.clock = pygame.time.Clock()
        self.level = Level()

    def run(self):
        while True:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()

            self.screen.fill("black")
            self.level.run()
            pygame.display.update()
            self.clock.tick(s.FPS)


if __name__ == "__main__":
    game = Game()
    game.run()
