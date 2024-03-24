import pages
import home_page
import theme
import os
import uvicorn
from fastapi import FastAPI
from nicegui import app, ui
import ssl

ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
ssl_context.load_cert_chain('/app/frontend/ca_bundle.pem', keyfile='/app/frontend/private.pem')
app = FastAPI()

# here we use our custom page decorator directly and just put the content creation into a separate function
@ui.page('/')
def index_page() -> None:
    with theme.frame('Oracle Cloud Infrastructure Demo'):
        home_page.content()


# this call shows that you can also move the whole page creation into a separate file
pages.create()
app.add_static_files('/.well-known/pki-validation', 'pki')

ui.run_with(app)
# ui.run(
#     title='OCI Cloud Infrastructure Demo',
#     port=int(os.environ.get("HTTP_PORT")),
#     uvicorn_logging_level="info",
#     ssl=ssl_context
#     # ssl_certfile="/app/frontend/ca_bundle.pem",
#     # ssl_keyfile="/app/frontend/private.pem",
# )

uvicorn.run(app, host='0.0.0.0', port=443)