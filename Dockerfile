FROM python:3.11

RUN pip install pip-licenses-cli==1.0.0 pipdeptree

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY allowed-licenses.txt /allowed-licenses.txt
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

