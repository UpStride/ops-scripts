### stage 1: building python
FROM marcelndeffo/tools:ffmpeg-weekly as pre-build

WORKDIR /src/

#building python
#python virtual env
RUN apt install -y python3-venv
RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH
#sources dependencies
COPY requirements-python.txt .
RUN pip install -r requirements-python.txt

### stage 2: final image
FROM marcelndeffo/tools:ffmpeg-weekly

USER root

ENV VERBOSE ''

WORKDIR /src/

#copy all sources to /src
COPY . /src/
RUN chmod +x /src/*/*.sh /src/*/run

#build
#copying python binaries
COPY --from=pre-build /venv /venv
ENV PATH=/venv/bin:$PATH

#unittests
RUN VERBOSE='TRUE' ./tests/dry-run.sh
RUN VERBOSE='TRUE' ./tests/compute-audio.sh

#set entrypoint to bash
ENTRYPOINT '/bin/sh'
