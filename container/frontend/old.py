from nicegui import ui
import db
from router import Router


@ui.page('/')  # normal index page (e.g. the entry point of the app)
@ui.page('/{_:path}')  # all other pages will be handled by the router but must be registered to also show the SPA index page
def main():
    router = Router()

    @router.add('/')
    def show_one():
        ui.label('Content One').classes('text-2xl')
        ui.html('<iframe style="height:300px; width:300px;" src="https://renielcanlas.github.io"><b>IFrame is available here</b></iframe>')

    @router.add('/two')
    def show_two():
        ui.label('Content Two').classes('text-2xl')

    @router.add('/three')
    def show_three():
        ui.label('Content Three').classes('text-2xl')

    # adding some navigation buttons to switch between the different pages
    with ui.row():
        ui.button('One', on_click=lambda: router.open(show_one)).classes('w-32')
        ui.button('Two', on_click=lambda: router.open(show_two)).classes('w-32')
        ui.button('Three', on_click=lambda: router.open(show_three)).classes('w-32')

    # this places the content which should be displayed
    router.frame().classes('w-full p-4 bg-gray-100')


ui.run()




# ui.label('Hello NiceGUI!')
# ui.button('BUTTON', on_click=lambda: ui.notify(db.test()))

# with ui.header().classes(replace='row items-center') as header:
#     ui.button(on_click=lambda: left_drawer.toggle(), icon='menu').props('flat color=white')
#     with ui.tabs() as tabs:
#         ui.tab('A')

# with ui.left_drawer().classes('bg-blue-100') as left_drawer:
#     ui.label('Side menu')

# with ui.tab_panels(tabs, value='A').classes('w-full'):
#     with ui.tab_panel('A'):
#         ui.label('Content of A')

# ui.run(
#     port=8080,
#     uvicorn_logging_level="info"
# )