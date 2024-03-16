# oracle
OCI infrastructure

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

When prompted, enter your username in the format <tenancy-namespace>/<username>. 

```<namespace>/<username-of-auth-token>```

If your tenancy is federated with Oracle Identity Cloud Service, use the format <tenancy-namespace>/oracleidentitycloudservice/<username>.