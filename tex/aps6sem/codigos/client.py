from concurrent.futures import thread
from email import message
from pickle import TRUE
import socket
import threading

apelido =input("Defina seu Nick: ")

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(('127.0.0.1', 24546))

def receber():
    while True:
        try:
            message = client.recv(1024).decode('utf-8')
            if message == 'NICK':
                client.send(apelido.encode('utf-8'))
            else:
                print(message)
        except:
            print("Ocorreu um erro!")
            client.close()
            break

def escrever():
    while True:
        message = '{}: {}'.format(apelido, input(''))
        client.send(message.encode('utf-8'))


receber_thread = threading.Thread(target=receber)
receber_thread.start()

escrever_thread = threading.Thread(target=escrever)
escrever_thread.start()
