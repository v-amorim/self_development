def jogar():
    print("***************************")
    print("Bem vindo ao jogo da Forca!")
    print("***************************")

    palavra_secreta = "abobora".upper()
    letras_acertadas = ["_" for _ in palavra_secreta]

    enforcou = False
    acertou = False
    erros = 0

    print(letras_acertadas)

    while (not enforcou and not acertou):
        chute = input("Qual letra? ").strip().upper()
        if chute in palavra_secreta:
            for index, letra in enumerate(palavra_secreta):
                if (chute == letra):
                    letras_acertadas[index] = letra
        else:
            erros += 1

        enforcou = erros == 6
        acertou = "_" not in letras_acertadas
        print(letras_acertadas)

    if (acertou):
        print("Você ganhou!")
    else:
        print("Você perdeu!")

    print("Fim do jogo")


if __name__ == "__main__":
    jogar()
