from email import message
import threading
import socket


host = '127.0.0.1' #Localhost 
porta = 24546 #Porta

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((host, porta))
server.listen()

clientes = []
apelidos = []

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
            broadcast('{} Saiu!'.format(apelido).encode('utf-8'))
            apelidos.remove(apelidos)
            break

def receber():
    while True:
        
        client, endereço = server.accept()
        print("conectado com {}".format(endereço))
        
        client.send('NICK'.encode('utf-8'))
        apelido = client.recv(1024).decode('utf-8')
        apelidos.append(apelido)
        clientes.append(client)


        print("O Apelido é {}!".format(apelido))
        broadcast( '{} entrou no Chat!'.format(apelido).encode('utf-8'))
        client.send("Conectado ao servidor!".encode('utf-8'))

        thread = threading.Thread(target=handle, args=(client,))
        thread.start()

print("O servidor está esperando...")
receber()