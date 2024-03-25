FROM zauberzeug/nicegui

RUN apt-get update
RUN apt-get install -y vim

COPY frontend frontend
COPY start.sh frontend/start.sh

WORKDIR /app/frontend

RUN python3 -m pip install --upgrade pip wheel
RUN python3 -m pip install --no-cache-dir --upgrade -r requirements.txt

ENV OCI_CLI_AUTH=resource_principal