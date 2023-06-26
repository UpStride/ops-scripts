### stage 1: building python
FROM python:3.10-slim as pre-build

WORKDIR /src/

#building python
COPY requirements-python.txt .
RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH
RUN pip install -r requirements-python.txt

### stage 2: final image
FROM python:3.10-slim

ENV VERBOSE='TRUE'

WORKDIR /src/

#copy all sources to /src
COPY . /src/
RUN chmod +x /src/*/*.sh /src/*/run

#build
#copying pyhton binaries
COPY --from=pre-build /venv /venv
ENV PATH=/venv/bin:$PATH
#external programs
RUN apt update
RUN apt install -y file ffmpeg

#test suite
RUN ./tests/dry-run.sh
RUN ./tests/compute-audio.sh
RUN ./tests/browse-github.sh
