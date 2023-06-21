FROM python:3.10-bullseye

WORKDIR /src/

#copy all sources to /src
COPY . /src/

# Install requirements
RUN pip install -r requirements-python.txt
RUN apt update
RUN apt install -y ffmpeg

#Test Suite
RUN ./tests/dry-run.sh
RUN ./tests/compute-audio.sh
