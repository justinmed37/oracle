from nicegui import ui
import db

ui.label('Hello NiceGUI!')
ui.button('BUTTON', on_click=lambda: ui.notify(str(db.test())))

ui.run(
    port=80,
    uvicorn_logging_level="info"
)