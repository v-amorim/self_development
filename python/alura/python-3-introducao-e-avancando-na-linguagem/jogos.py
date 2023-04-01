from __future__ import annotations

import adivinhacao
import forca


def escolher_jogo():
    print('******************')
    print('Escolha o seu jogo')
    print('******************')

    print('(1) Forca\t(2) Adivinhação')

    jogo = int(input('Qual jogo? '))

    if (jogo == 1):
        print('Jogando Forca')
        forca.jogar()
    elif (jogo == 2):
        print('Jogando Adivinhação')
        adivinhacao.jogar()


if __name__ == '__main__':
    escolher_jogo()
