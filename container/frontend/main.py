import pages
import home_page
import theme
import os
from nicegui import app, ui


# here we use our custom page decorator directly and just put the content creation into a separate function
@ui.page('/')
def index_page() -> None:
    with theme.frame('Oracle Cloud Infrastructure Demo'):
        home_page.content()


# this call shows that you can also move the whole page creation into a separate file
pages.create()
app.add_static_files('/.well-known/pki-validation', 'pki')

ui.run(
    title='OCI Cloud Infrastructure Demo',
    port=int(os.environ.get("HTTP_PORT")),
    uvicorn_logging_level="info"
)