#!/bin/bash

# Variables
ROOT_CERT_SUBJECT="/CN=MyRootCert"
CLIENT_CERT_SUBJECT="/CN=MyClientCert"
ROOT_CERT_PASSWORD="rootpassword"
CLIENT_CERT_PASSWORD="clientpassword"

# Generate Root Certificate
openssl req -x509 -newkey rsa:2048 -keyout rootCA.key -out rootCA.crt -days 365 -nodes -subj $ROOT_CERT_SUBJECT

# Generate Client Certificate
openssl req -new -newkey rsa:2048 -keyout client.key -out client.csr -nodes -subj $CLIENT_CERT_SUBJECT
openssl x509 -req -in client.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out client.crt -days 365

# Convert Client Certificate to PFX
openssl pkcs12 -export -out client.pfx -inkey client.key -in client.crt -certfile rootCA.crt -password pass:$CLIENT_CERT_PASSWORD

echo "Certificates generated successfully."