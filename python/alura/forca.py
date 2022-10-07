def jogar():
    print("***************************")
    print("Bem vindo ao jogo da Forca!")
    print("***************************")

    palavra_secreta = "banana".upper()
    letras_acertadas = ["_", "_", "_", "_", "_", "_"]
    print(letras_acertadas)

    enforcou = False
    acertou = False
    erros = 0

    while (not enforcou and not acertou):
        chute = input("Qual letra? ").strip().upper()
        if chute in palavra_secreta:
            for index, letra in enumerate(palavra_secreta):
                if (chute == letra):
                    letras_acertadas[index] = letra
        else:
            erros += 1
            print(f"Faltam {6 - erros} tentativas.")

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
