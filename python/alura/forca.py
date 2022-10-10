def jogar():
    imprime_mensagem_abertura()
    palavra_secreta = carrega_palavra_secreta()
    letras_acertadas = inicializa_letras_acertadas(palavra_secreta)

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


def imprime_mensagem_abertura():
    print("***************************")
    print("Bem vindo ao jogo da Forca!")
    print("***************************")
    print("\n")


def carrega_palavra_secreta():
    import random
    palavras = []

    with open("palavras.txt", "r") as arquivo:
        for linha in arquivo:
            linha = linha.strip()
            palavras.append(linha)

    escolhida = random.randrange(0, len(palavras))
    return palavras[escolhida].upper()


def inicializa_letras_acertadas(palavra_secreta):
    letras_acertadas = ["_" for _ in palavra_secreta]
    print(letras_acertadas)
    return letras_acertadas


if __name__ == "__main__":
    jogar()
