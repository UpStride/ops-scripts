### stage 1: building python
FROM jrottenberg/ffmpeg:6.0-ubuntu as pre-build

WORKDIR /src/

#building python
COPY requirements-python.txt .
RUN apt update && apt install -y python3 python3-venv python3-pip
RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH
RUN pip install -r requirements-python.txt

### stage 2: final image
FROM jrottenberg/ffmpeg:6.0-ubuntu

USER root

ENV VERBOSE ''

WORKDIR /src/

#copy all sources to /src
COPY . /src/
RUN chmod +x /src/*/*.sh /src/*/run

#build
#copying pyhton binaries
RUN apt update
RUN apt install -y python3
COPY --from=pre-build /venv /venv
ENV PATH=/venv/bin:$PATH

#unittests
RUN VERBOSE='TRUE' ./tests/dry-run.sh
RUN VERBOSE='TRUE' ./tests/compute-audio.sh

#set entrypoint to bash
ENTRYPOINT '/bin/sh'
