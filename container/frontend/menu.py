from nicegui import ui


def menu() -> None:
    ui.link('Home', '/').classes(replace='text-white')
    ui.link('Database Demo', '/demo').classes(replace='text-white')
    ui.link('Design', '/design').classes(replace='text-white')
