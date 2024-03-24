#!/bin/bash

oci os object get -bn secrets --file secret --name databases/generic-bu-auto-db-admin-password.txt

oci os object get -bn certificates --file certificate.pem --name devops-demo/certificate.pem
oci os object get -bn certificates --file private.pem --name devops-demo/private.pem

python3 main.py