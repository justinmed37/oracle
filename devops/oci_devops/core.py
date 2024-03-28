from os import environ
import json
import oci
from .log import logger

# Relevant environment variables:
# REQUIRED:
#   NAMESPACE: Tenancy namespace
#   APPLICATION_TARGET: This is the friendly name of your projects "root" compartment.
#       In this case, it will be "generic-bu"
#   ALIAS_TARGET: Backwards compatability for some naming stuff I need to refactor to fix
#       In this case it will be "generic_bu" (the compartment should just be named generic-bu)
#
# OPTIONAL:
#   These two variables help us control authentication so we can support 
#       multiple use cases - local development and using resource principal auth
#       when deployed as a container resource
#   Default is to configure your docker run command so the relevent
#       .oci/config and api_key resources get mounted from your local file system
#
# RESOURCE_PRINCIPAL: Set to true when running container in OCI
# TENANCY_ID: Required when running in OCI

config = {}
signer = {}
tenancy = environ.get('TENANCY_ID', None)


logger.info(f"INIT_OCI_DEVOPS")
# This resource principal code is untested yet, placeholder until needed
if environ.get('RESOURCE_PRINCIPAL', None) is not None and tenancy is not None:
    # Create a Response Pricipals signer
    logger.info(f"INIT_RESOURCE_PRINCIPAL_SIGNER")
    signer = oci.auth.signers.get_resource_principals_signer()
    logger.debug(f"RESOURCE_PRINCIPAL_SECURITY_TOKEN: {signer.get_security_token()}")
else:
    # Use the config file to authenticate
    logger.info(f"INIT_LOCAL_CONFIG")
    config = oci.config.from_file()
    tenancy = config["tenancy"]
    logger.debug(f"OCI_CLI_CONFIG: {config}")


# Open our Infrastructure Model computed from our Terraform
f = open('model.tmp.json')
model = json.load(f)