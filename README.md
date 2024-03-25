# OCI DevOps Template
This repository is my initial take at creating a source template with the following:

1. Oracle Cloud Infrastructure provider
1. Python web application / API (NiceGUI/FastAPI)
1. Autonomous JSON DB for suitability of ACID transactions
1. Infrastructure Orchestration Terraform and GitHub Actions
1. Firewall (GeoFencing), HTTPS/SSL
1. Observability (TBD) - Built in OCI features, datadog integration later

## DevOps Demo

[DevOps-Demo.com](https://devops-demo.com)

## Architecture

### Infrastructure and Terraform
Network and Application Infrastructure. The folder structure of the infrastructure is intended to provide an intuitive way to manage the systems infrastructure and architecture.

1. **infrastructure/bootstrap** - Top level containers and buckets needed to bootstrap the remote terraform backend for each layer / component
1. **infrastructure/shared_modules** - Re-usable modules used for sharing OCIDs across terraform states or simple patterns for constructing things like a public or private network
1. **infrastructure/network** - VCN, Subnets, Security Lists, Network Security Groups, Routing, Internet Gateway, read (bucket|repo|object) dynamic group policy, 
1. **infrastructure/container** - Application container repo, container instance, nsg policy, bucket, 
1. **Infrastructure/database** - OCI Autonomous Database resource configured as AJD
    - Configured for free tier, however the service supports ACID transactions

### Application - Container / Python
1. **Python Packages**
    - NiceGUI - This python library runs the web server on top of FastAPI
    - oracledb - This library enables us to interact with the OCI autonomous JSON db
    - oci-cli - Used during runtime to retrieve secrets and certificates from object storage
1. **Container Details**
    - **run_command**: ```container/frontend/start.sh```
    - Container Registry - Uses OCI Container Registry
    - Build and Push - Integrated with GitHub actions to build and push to OCI CR
    - Dev Experience - This enables the developer to auto push changes to the repo, which can then be tested by restarting the container instance
1. **DRY Code**
    - Keep any environment configuration outside the source code and in secrets / env variables
    - Leverage object storage for static files and secrets



### Orchestration and GitHub Actions

1. **.github/workflows/container.yaml** - Container Builder
    - Automatically runs when pushing changes into an open PR against MAIN
    - Uses an auth token to authenticate with oci container repository
1. **.github/workflows/tf_changes.yaml** - Infrastructure Orchestration for Terraform
    - Automatically runs when pushing changes into an open PR against MAIN
    - Checks terraform directories for changes to files to determine which components to run
    - Performs several sanity checks and integrates with the GitHub bot to summarize results in the PR
    - Sanity checks are integrated with GitHub to prevent merging a PR with failing checks
    - Currently it's limited to generating plans, as there are quite a few additional features needed before it's ready to automatically apply all the terraform

## Developer Notes

### Setup User API Key

1. Login to oracle console
1. Open user profile, generate the api key and download them
1. Copy the contents of the private key .pem file into ~/.ssh/oci.pem

### Setup OCI CLI for config file auth

1. ```sudo apt install python3-pip```
1. ```python3 -m venv venv```
1. ```source venv/bin/activate```
1. ```python -m pip install oci-cli --upgrade```


### Setup config file

1. ```mkdir ~/.oci```
1. ```touch ~/.oci/config```
1. Paste in config file from oracle console to the config file
1. Set the private key location to /home/$USER/.ssh/oci.pem
1. ```export TF_VAR_config_file_profile="/home/$USER/.oci/config"```


### Container Registry Notes

1. Log in to docker ```docker login iad.ocir.io```
When prompted, enter your username in the format <tenancy-namespace>/<username>. 

```<namespace>/<username-of-auth-token>```

If your tenancy is federated with Oracle Identity Cloud Service, use the format <tenancy-namespace>/oracleidentitycloudservice/<username>.


### Some quick notes on certificates

1. setup oci load balancer
1. setup domain - used squarespace
1. configure load balancer and squarespace dns entries
1. use sslforfree.com to sign up for ssl certs 90d are free
1. setup the manual http verification for domain ownership verification
1. download certs
1. looks like they need to be converted to .pem format with openssl
1. the certs can then be provided to the nicegui ui.run(ssl_certfile= and ssl_keyfile=)