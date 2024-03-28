from .client import *


response = container(client.start_container_instance, container_id)
print(response.data) # deleteme