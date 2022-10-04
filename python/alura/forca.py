def jogar():
    print("***************************")
    print("Bem vindo ao jogo da Forca!")
    print("***************************")

    palavra_secreta = "banana".upper()
    letras_acertadas = ["_", "_", "_", "_", "_", "_"]
    print(letras_acertadas)
    enforcou = False
    acertou = False
    while (not enforcou and not acertou):
        chute = input("Qual letra? ").strip().upper()
        index = 0
        for letra in palavra_secreta:
            if (chute == letra):
                letras_acertadas[index] = letra
            index = index + 1
        print(letras_acertadas)
        letras_faltando = str(letras_acertadas.count('_'))
        print(f'Ainda faltam acertar {letras_faltando} letras')

    print("Fim do jogo")


if __name__ == "__main__":
    jogar()
