import ftplib
import ssl


class MyFTP_TLS(ftplib.FTP_TLS):
    
    """Explicit FTPS, with shared TLS session."""
    def ntransfercmd(self, cmd, rest=None):
        conn, size = ftplib.FTP.ntransfercmd(self, cmd, rest)
        if self._prot_p:
            session = self.sock.session
            if isinstance(self.sock, ssl.SSLSocket):
                session = self.sock.session
            conn = self.context.wrap_socket(conn,
                                            server_hostname=self.host,
                                            session=session)  # this is the fix
        return conn, size


ftp = MyFTP_TLS()

USER = "login"
PASS = "password"
SERVER = "server"
PORT = 21
BINARY_STORE = True

print (ftp.connect(SERVER, PORT))
print (ftp.login(USER, PASS))
print (ftp.prot_p())
print (ftp.set_pasv(True))

print (ftp.cwd("/www/domains"))
print (ftp.retrlines('LIST'))

filename = 'test.txt'
content = open(filename, "rb")
print (ftp.storbinary('STOR %s' % filename, content))

ftp.quit()
