FROM zauberzeug/nicegui

COPY frontend frontend

WORKDIR /app/frontend

RUN python3 -m pip install --no-cache-dir --upgrade -r requirements.txt

# ENTRYPOINT [ "python3", "main.py" ]