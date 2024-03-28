from .client import *


# Pass the client function and container_id to the function wrapper
response = container(client.start_container_instance, container_id)