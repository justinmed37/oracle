# oracle
OCI infrastructure

## Notes

### Setup User API Key
Login to oracle console
Open user profile, generate the api key and download them
Copy the contents of the private key .pem file into ~/.ssh/oci.pem

### Setup OCI CLI for config file auth
sudo apt install python3-pip
python3 -m venv venv
source venv/bin/activate
python -m pip install oci-cli --upgrade


### Setup config file
mkdir ~/.oci
touch ~/.oci/config
Paste in config file from oracle console to the config file
Set the private key location to /home/$USER/.ssh/oci.pem
export TF_VAR_config_file_profile="/home/$USER/.oci/config"