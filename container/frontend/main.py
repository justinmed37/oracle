import pages
import home_page
import theme
import os
from fastapi import FastAPI
from nicegui import ui
import ssl

# ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
# ssl_context.load_cert_chain('/app/frontend/ca_bundle.pem', keyfile='/app/frontend/private.pem')
# server = FastAPI()

# here we use our custom page decorator directly and just put the content creation into a separate function
@ui.page('/')
def index_page() -> None:
    with theme.frame('Oracle Cloud Infrastructure Demo'):
        home_page.content()


# this call shows that you can also move the whole page creation into a separate file
pages.create()

# ui.run_with(server)
ui.run(
    title='OCI Cloud Infrastructure Demo',
    port=int(os.environ.get("HTTP_PORT")),
    uvicorn_logging_level="info",
    ssl_certfile="/app/frontend/certificate.pem",
    ssl_keyfile="/app/frontend/private.pem",
)

# uvicorn.run(server, port=int(os.environ.get("HTTP_PORT")), ssl=ssl_context)
# uvicorn.run(server,
#     port=int(os.environ.get("HTTP_PORT")),
#     ssl_certfile="/app/frontend/ca_bundle.pem",
#     ssl_keyfile="/app/frontend/private.pem"
# )