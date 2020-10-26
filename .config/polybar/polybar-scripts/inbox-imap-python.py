#!/usr/bin/python

import imaplib

email_address = 'qvshuo@foxmail.com'
password = 'hhbuejivisticgji'
imap_server = 'imap.qq.com'

obj = imaplib.IMAP4_SSL(imap_server, 993)
obj.login(email_address, password)
obj.select()

print("",len(obj.search(None, 'unseen')[1][0].split()))
