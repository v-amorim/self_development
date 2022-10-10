def jogar():
    import random
    print("***************************")
    print("Bem vindo ao jogo da Forca!")
    print("***************************")

    palavras = []

    with open("palavras.txt", "r") as arquivo:
        for linha in arquivo:
            linha = linha.strip()
            palavras.append(linha)

    escolhida = random.randrange(0, len(palavras))
    palavra_secreta = palavras[escolhida].upper()
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
