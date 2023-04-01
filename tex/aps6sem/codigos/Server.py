from __future__ import annotations

import socket
import threading
from email import message


host = '127.0.0.1'  # Localhost
porta = 24546  # Porta

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((host, porta))
server.listen()

clientes: list = []
apelidos: list = []


def broadcast(message):
    for client in clientes:
        client.send(message)


def handle(client):
    while True:
        try:
            message = client.recv(1024)
            broadcast(message)
        except:
            index = clientes.index(client)
            clientes.remove(client)
            client.close()
            apelido = apelidos[index]
            broadcast(f'{apelido} Saiu!'.encode())
            apelidos.remove(apelidos)
            break


def receber():
    while True:

        client, endereço = server.accept()
        print(f'conectado com {endereço}')

        client.send(b'NICK')
        apelido = client.recv(1024).decode('utf-8')
        apelidos.append(apelido)
        clientes.append(client)

        print(f'O Apelido é {apelido}!')
        broadcast(f'{apelido} entrou no Chat!'.encode())
        client.send(b'Conectado ao servidor!')

        thread = threading.Thread(target=handle, args=(client,))
        thread.start()


print('O servidor está esperando...')
receber()
