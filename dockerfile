FROM python:3.10-bullseye

ENV VERBOSE='TRUE'

WORKDIR /src/

#copy all sources to /src
COPY . /src/
RUN chmod +x /src/*/*.sh /src/*/run

#install requirements
RUN pip install -r requirements-python.txt
RUN apt update
RUN apt install -y ffmpeg

#test suite
RUN ./tests/dry-run.sh
RUN ./tests/compute-audio.sh
RUN ./tests/browse-github.sh
