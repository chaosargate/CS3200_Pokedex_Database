#!/usr/bin/env python
import SimpleHTTPServer
import SocketServer
import mysql.connector

class MyRequestHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.path = '/'
        print "Stuff"
        return SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)


PORT = 8000

Handler = MyRequestHandler
server = SocketServer.TCPServer(('0.0.0.0', PORT), Handler)

print "Serving at port", PORT

server.serve_forever()




cnx = mysql.connector.connect(user='scott', password='tiger',
                              host='127.0.0.1',
                              database='employees')
cnx.close()