import pages
import home_page
import theme
import os
from nicegui import ui


# here we use our custom page decorator directly and just put the content creation into a separate function
@ui.page('/')
def index_page() -> None:
    with theme.frame('Homepage'):
        home_page.content()


# this call shows that you can also move the whole page creation into a separate file
pages.create()

ui.run(
    title='OCI Cloud Infrastructure Demo',
    port=os.environ.get("FRONTEND_PORT"),
    uvicorn_logging_level="info"
)