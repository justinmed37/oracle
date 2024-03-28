from os import environ
import json
import oci


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
tenancy = ""

# This resource principal code is untested yet, placeholder until needed
if environ.get('RESOURCE_PRINCIPAL') is not None and environ.get('TENANCY_ID') is not None:
    # Create a Response Pricipals signer
    print("=" * 80)
    print("Intializing new signer")
    signer = oci.auth.signers.get_resource_principals_signer()

    # Print the Resource Principal Security Token
    # This step is not required to use the signer, it just shows that the security
    # token can be retrieved from the signer.
    print("=" * 80)
    print("Resource Principal Security Token")
    print(signer.get_security_token())
else:
    config = oci.config.from_file()
    tenancy = config["tenancy"]



# Initially had WAY more code here trying to extract all the OCIDs from the tenancy
#      ...that was no fun.
#
# New method extracts everything via TRANS_TERRAFORM_PYTHON_ALCHEMY
#       ...I just made that up.

f = open('model.tmp.json')
model = json.load(f)

# who is json and why do they dump all the time???
print(json.dumps(model, sort_keys=True, indent=2))