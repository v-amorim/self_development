from Crypto.Cipher import DES3
from Crypto import Random
import sqlite3

key = 'Sixteen byte key'  # Tamanho da chave tem q ser 16 ou 24 bits


def criar(usuario, senha):
    conn = sqlite3.connect('bancodedados.db')  # Conexão com o BD
    cursor = conn.cursor()  # Cursor pra poder manipular o BD
    iv = Random.new().read(DES3.block_size)  # Sera salvo no BD encryptada, em formato binario
    cipher_encrypt = DES3.new(key, DES3.MODE_OFB, iv)  # Encryptação usando a Key e o IV gerado
    senha_enc = cipher_encrypt.encrypt(bytes(senha, encoding='utf-8'))  # Será salvo no BD encryptada, convertendo para formato binario
    cursor.execute("""SELECT usuario FROM login;""")  # O cursor vai selecionar a coluna de usuarios da tabela de "login"
    tabela_bd = cursor.fetchall()  # Guarda nessa variavel todos os usuarios
    if tabela_bd == []:  # Caso o banco de dados esteja vazio na 1a vez que abrir
        if senha == '':  # Caso a senha digitada esteja em branco
            return 2
        else:
            cursor.execute("""INSERT INTO login (usuario, senha) VALUES (?, ?);""", (usuario, senha_enc))  # Joga os dados no BD
            cursor.execute("""INSERT INTO chaves (iv) VALUES (?);""", (iv,))  # Joga os dados no BD
            conn.commit()  # Confirma e "salva" no BD
            conn.close()  # Fecha a conexão com o BD
            return 1

    if usuario in tabela_bd[0] or senha == '':  # Se já existir o usuario ou a senha digitada estiver em branco, retornar 2 para exibir mensagem de erro
        return 2
    else:
        cursor.execute("""INSERT INTO login (usuario, senha) VALUES (?, ?);""", (usuario, senha_enc))  # Joga os dados no BD
        cursor.execute("""INSERT INTO chaves (iv) VALUES (?);""", (iv,))  # Joga os dados no BD
        conn.commit()  # Confirma e "salva" no BD
        conn.close()  # Fecha a conexão com o BD
        return 1
