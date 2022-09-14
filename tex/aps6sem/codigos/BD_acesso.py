from Crypto.Cipher import DES3
from Crypto import Random
import sqlite3

key = 'Sixteen byte key'  # Tamanho da chave tem q ser 16 ou 24 bits


def acessar(usuario, senha):

    conn = sqlite3.connect('bancodedados.db')  # Conexão com o BD
    cursor = conn.cursor()  # Cursor pra poder manipular o BD
    cursor.execute("""SELECT * FROM login;""")  # O cursor vai selecionar a tabela "login"
    tabela_bd = cursor.fetchall()  # E dela vai extrair tudo e jogar nessa variavel numa tupla
    cursor.execute("""SELECT iv FROM chaves;""")
    tabela_iv = cursor.fetchall()
    linha = 0
    verifica = False
    if verifica == False:
        while linha < len(tabela_bd):
            if tabela_bd[linha][0] == usuario:  # Se o usuario bater com o guardado no BD
                cipher_decrypt = DES3.new(key, DES3.MODE_OFB, tabela_iv[linha][0])  # Gera uma chave usando a Key e o IV deste usuario salvo no BD
                senha_dec = (cipher_decrypt.decrypt(tabela_bd[linha][1]).decode("utf-8"))  # Decryptação com a Key, IV e Senha pegos do BD e então converte-a de binario pra string
                if senha == senha_dec:  # Se a senha bater com a guardada no BD
                    verifica = True
                    return 1
                else:  # Se a senha não bater com a guardada no BD
                    verifica = True
                    return 2
            linha += 1
    if verifica == False:  # Se o usuario não bater com o guardado no BD
        return 3
    conn.close()  # Fecha a conexão com o BD
