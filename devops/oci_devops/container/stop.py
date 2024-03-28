from .client import *


# Pass the client function and container_id to the function wrapper
response = container(client.stop_container_instance, container_id)