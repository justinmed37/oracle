
# Import code from the core module where we setup config
from ..core import config, signer, model
from ..log import logger
import oci
import sys


# Get the container ID of the corresponding resource by NAME
def _get_container_id(list, name):
    id = ""
    for each in list:
        if each["display_name"] == name:
            id = each["id"]
    return id

# Generic container function
def container(func, id):
    # Execute the client function
    resp = func(id)
    
    # log responses
    logger.debug(f"RESPONSE_STATUS: {resp.status}")
    logger.debug(f"RESPONSE_DATA: {resp.data}")
    return resp


# logs
logger.debug(f"OCI_DEVOPS_INVOCATION: {sys.argv[0]}")

# Initialize the container instance client
client =  oci.container_instances.ContainerInstanceClient(config)

# Simple targeting parameter for now, can provide more robust target filtering later
container_id = ""
if len(sys.argv) <= 1:
    logger.error(f"INVOCATION_ERROR: Must provide container instance name")

# Get the container name from argv
container_name = sys.argv[1]

# Set the container ID
container_id = _get_container_id(model['containers'][0]["items"], container_name)