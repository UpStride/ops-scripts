FROM python:3.10.12-alpine

ENV VERBOSE='TRUE'

WORKDIR /src/

#copy all sources to /src
COPY . /src/
RUN chmod +x /src/*/*.sh /src/*/run

#install requirements
# python
RUN apk add --no-cache --update-cache make automake gcc g++ freetype-dev libpng-dev openblas-dev python3-dev
#RUN pip install -U pip
RUN pip install -r requirements-python.txt
# audio
RUN apk --no-cache add -y ffmpeg

#test suite
RUN ./tests/dry-run.sh
RUN ./tests/compute-audio.sh
RUN ./tests/browse-github.sh
