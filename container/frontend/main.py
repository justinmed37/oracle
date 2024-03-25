import pages
import home_page
import theme
import os
from nicegui import ui
import ssl


# here we use our custom page decorator directly and just put the content creation into a separate function
@ui.page('/')
def index_page() -> None:
    with theme.frame('DevOps Demo'):
        home_page.content()


# this call shows that you can also move the whole page creation into a separate file
pages.create()

ui.run(
    title='DevOps Demo',
    port=int(os.environ.get("HTTP_PORT")),
    uvicorn_logging_level="info",
    ssl_certfile="/app/frontend/certificate.pem",
    ssl_keyfile="/app/frontend/private.pem",
)

