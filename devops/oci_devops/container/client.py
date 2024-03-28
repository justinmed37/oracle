
# Import code from the core module where we setup config
from ..core import config, signer, model
import oci

# Initialize the container instance client
client =  oci.container_instances.ContainerInstanceClient(config)

# Targeting the container will need more logic, for now we just have the one
container_id = model['containers'][0]["items"][0]["id"]

# Generic container function
def container(func, id):
    resp = func(id)
    return resp
