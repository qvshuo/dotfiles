#!/usr/bin/python

import imaplib

email_address = ''
password = ''
imap_server = ''

obj = imaplib.IMAP4_SSL(imap_server, 993)
obj.login(email_address, password)
obj.select()

print("",len(obj.search(None, 'unseen')[1][0].split()))
