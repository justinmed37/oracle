#!/bin/bash

oci os object get -bn secrets --file secret --name databases/generic-bu-auto-db-admin-password.txt

python3 main.py