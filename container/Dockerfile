FROM zauberzeug/nicegui

# RUN apt-get update
# RUN apt-get install -y wget curl
# RUN wget https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh
# RUN chmod +x install.sh && ./install.sh --accept-all-defaults

COPY frontend frontend
COPY start.sh frontend/start.sh

WORKDIR /app/frontend

RUN python3 -m pip install --upgrade pip wheel
RUN python3 -m pip install --no-cache-dir --upgrade -r requirements.txt

ENV OCI_CLI_AUTH=resource_principal
# wget https://download.oracle.com/otn_software/linux/instantclient/2113000/oracle-instantclient-basic-21.13.0.0.0-1.x86_64.rpm
# alien -i --scripts oracle-instantclient*.rpm
# ENTRYPOINT [ "python3", "main.py" ]