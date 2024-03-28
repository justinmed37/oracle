import oci
from os import environ

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


namespace = environ.get('NAMESPACE')
os_client = oci.object_storage.ObjectStorageClient(config)
print(f"Namespace: {os_client.get_namespace().data}")
bucket = os_client.get_bucket(
    namespace_name=os_client.get_namespace().data,
    bucket_name="infrastructure_model"
)
print(dir(bucket))
print(bucket.data)
model = os_client.get_object(
    namespace_name=os_client.get_namespace().data,
    bucket_name='infrastructure_model',
    object_name='model.json')

import pdb;pdb.set_trace()
print(dir(model))
print(f"{model.data}")


def identity(config, tenancy, filter):
    client = oci.identity.IdentityClient(config)
    compartments = client.list_compartments(tenancy)

    for each in compartments.data:
        if each.name == filter:
            compartment = each

    # print(f"Compartments: {compartments.data}")
    return client, compartment

def network(config, compartment_id, target):
    client = oci.core.VirtualNetworkClient(config)
    vcns = client.list_vcns(compartment_id)
    # Formulate the target name (tn) as it appears in infrastructure/network/main.py for the vcn
    tn = f"{target}-network" # In this case it will look like "generic-bu-network", the vcn name

    # Loop through and get our target vcn
    for each in vcns.data:
        if each.display_name == tn:
            vcn = each
  
    subnets = client.list_subnets(compartment_id)
    #print(subnets.data)

    return vcn, subnets.data

# if environ.get('ALIAS_TARGET') is not None:
#     ident, compartment = identity(config, tenancy, environ.get('ALIAS_TARGET'))
# else:
#     ident, compartment = identity(config, tenancy, environ.get('APPLICATION_TARGET'))



# print(f"Application Compartment: {compartment.id}")
# print(f"{compartment}")

# target = environ.get('APPLICATION_TARGET')

# vcn, subnets = network(config, compartment.id, target)

# print(f"VCN_ID: {vcn.id}")
# print(f"{vcn}\n\n")

# print("=" * 80)
# print("SUBNETS")
# print("=" * 80)

# for each in subnets:
#     print(f"ID: {each.id}")
#     print(f"DISPLAY_NAME: {each.display_name}")
#     print(f"CIDR_BLOCK: {each.cidr_block}")
#     print("=" * 80)

# # subnets(config, compartment)