from nicegui import ui


def menu() -> None:
    ui.link('Home', '/').classes(replace='text-h5')
    ui.link('Database Demo', '/demo').classes(replace='text-h5')
    ui.link('Design', '/design').classes(replace='text-h5')
