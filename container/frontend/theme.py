from contextlib import contextmanager

from menu import menu

from nicegui import Tailwind, ui


@contextmanager
def frame(navtitle: str):
    '''Custom page frame to share the same styling and behavior across all pages'''
    ui.colors(
        primary='#f80000',
        secondary='#7f7f7f',
        accent='#111B1E',
        positive='#53B689',
    )
    dark = ui.dark_mode()
    dark.enable()
    with ui.header().classes('justify-between text-black text-h5'):
        with ui.row():
            ui.button('Dark', on_click=dark.enable)
            ui.button('Light', on_click=dark.disable)
        ui.label(navtitle).classes('absolute-center')
        with ui.row():
            menu()
    with ui.row().classes('absolute-center'):
        yield