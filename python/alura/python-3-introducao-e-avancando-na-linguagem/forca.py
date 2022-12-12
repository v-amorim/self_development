def jogar():
    imprime_mensagem_abertura()
    palavra_secreta = carrega_palavra_secreta()
    letras_acertadas = inicializa_letras_acertadas(palavra_secreta)

    enforcou = False
    acertou = False
    erros = 0

    while (not enforcou and not acertou):
        chute = input_chute()

        if chute in palavra_secreta:
            verifica_chute(chute, palavra_secreta, letras_acertadas)
        else:
            erros += 1
            desenha_forca(erros)

        enforcou = erros == 7
        acertou = "_" not in letras_acertadas
        print(letras_acertadas)

    if (acertou):
        mensagem_vencedor()
    else:
        mensagem_perdedor(palavra_secreta)


def imprime_mensagem_abertura():
    print("***************************")
    print("Bem vindo ao jogo da Forca!")
    print("***************************")
    print("\n")


def carrega_palavra_secreta(nome_arquivo="palavras.txt"):
    import random
    palavras = []

    with open(nome_arquivo, "r") as arquivo:
        for linha in arquivo:
            linha = linha.strip()
            palavras.append(linha)

    escolhida = random.randrange(0, len(palavras))
    return palavras[escolhida].upper()


def inicializa_letras_acertadas(palavra_secreta):
    letras_acertadas = ["_" for _ in palavra_secreta]
    print(letras_acertadas)
    return letras_acertadas


def input_chute():
    return input("Qual letra? ").strip().upper()


def verifica_chute(chute, palavra_secreta, letras_acertadas):
    for index, letra in enumerate(palavra_secreta):
        if (chute == letra):
            letras_acertadas[index] = letra


def mensagem_vencedor():
    print("Você ganhou!")


def mensagem_perdedor(palavra_secreta):
    print("Você perdeu!")
    print(f"A palavra era {palavra_secreta}.")


def desenha_forca(erros):
    print(f"Faltam {6 - erros} tentativas.")
    print("  _______     ")
    print(" |/      |    ")

    if(erros == 1):
        print(" |     (-_-)  ")
        print(" |            ")
        print(" |            ")
        print(" |            ")

    if(erros == 2):
        print(" |     (-_-)  ")
        print(" |       |    ")
        print(" |            ")
        print(" |            ")

    if(erros == 3):
        print(" |     (-_o)  ")
        print(" |      /|    ")
        print(" |            ")
        print(" |            ")

    if(erros == 4):
        print(" |     (o_o)  ")
        print(" |      /|\   ")
        print(" |            ")
        print(" |            ")

    if(erros == 5):
        print(" |     (o_o)  ")
        print(" |      /|\   ")
        print(" |       |    ")
        print(" |            ")

    if(erros == 6):
        print(" |     (oOo)  ")
        print(" |      /|\   ")
        print(" |       |    ")
        print(" |      /     ")

    if (erros == 7):
        print(" |     (x_x)  ")
        print(" |      /|\   ")
        print(" |       |    ")
        print(" |      / \   ")

    print(" |            ")
    print("_|___         ")
    print()


if __name__ == "__main__":
    jogar()
