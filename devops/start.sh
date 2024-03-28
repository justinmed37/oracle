#!/bin/bash
# blame @mcordry + @jmad

oci os object get -bn infrastructure_model \
    --file model.tmp.json \
    --name model.json