# OCI DevOps Template
This repository is my initial take at creating a source template with the following:

1. Oracle Cloud Infrastructure provider
1. Python web application / API (NiceGUI/FastAPI)
1. Autonomous JSON DB for suitability of ACID transactions
1. IaaC managed with Terraform
1. GitHub Actions integrate CI/CD with code change / PR process
1. Firewall (GeoFencing), HTTPS/SSL


## Notes

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