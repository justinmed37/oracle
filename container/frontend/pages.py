import theme

from nicegui import ui
import db

def create() -> None:

    @ui.page('/demo')
    def example_page():
        with theme.frame('Database Demo'):
            ui.label('Database Demo').classes('text-h4 text-grey-8')
            ui.button('TEST ME', on_click=lambda: ui.notify(db.test()))

    @ui.page('/design')
    def example_page():
        with theme.frame('- Design -'):
            ui.label('Design').classes('text-h4 text-grey-8')
