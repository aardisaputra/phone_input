import socket
import threading
from PyQt5.QtCore import QUrlQuery
import pyperclip

PORT = 5050
SERVER_NAME = socket.gethostname()
SERVER = socket.gethostbyname(socket.gethostname())
ADDR = (SERVER, PORT)
HEADER = 64
FORMAT = 'utf-8'
DISCONNECT_MESSAGE = "!DISCONNECT"

class myServer():
    def __init__(self):
        self.server = SERVER
        self.port = PORT
        self.address = ADDR
        self.actual_server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.actual_server.bind(ADDR)
        self.format = FORMAT
        self.header = HEADER
        self.disc_msg = DISCONNECT_MESSAGE
    
    def run(self, queue):
        empty = True
        self.actual_server.listen()
        print(f"[LISTENING] Server is listening on {self.server}")
        while empty:
            conn, addr = self.actual_server.accept()
            thread = threading.Thread(target=self.handle_client, args=(conn, addr, queue))
            thread.start()
            print(f"[ACTIVE CONNS] {threading.activeCount() - 1}")
            empty = False
        queue.put(True)

    def handle_client(self, conn, addr, queue):
        print(f"[NEW CONNECTION] {addr} connected.")

        connected = True
        while connected:
            msg = conn.recv(self.header)
            if msg:
                #print(msg)
                msg = msg.decode("utf-8")
                pyperclip.copy(msg)
                queue.put(msg)
                if msg == self.disc_msg:
                    connected = False
                print(f"[{addr}] {msg}")
        conn.close()

    