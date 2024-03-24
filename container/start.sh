#!/bin/bash -x
set -e

# Fetch the database secret from object store
oci os object get -bn secrets --file secret --name databases/generic-bu-auto-db-admin-password.txt

# Fetch the SSL .pem files for HTTPS
oci os object get -bn certificates --file certificate.pem --name devops-demo/certificate.pem
oci os object get -bn certificates --file private.pem --name devops-demo/private.pem

# Run the python niceGUI server
python3 main.py