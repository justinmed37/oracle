from .client import *


response = container(client.get_container_instance, container_id)
print(response.data) # deleteme