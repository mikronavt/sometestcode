import socket
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('0.0.0.0', 2222))
s.listen(10)
while True:
	conn, addr = s.accept()
	while True:
		data = conn.recv(1024)
		print(str(data).lower().find('close'))
		if not data: break
		if str(data).lower().find("close") > 0:
			break
		conn.send(data)
	conn.close()
	