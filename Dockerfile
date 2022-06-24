FROM debian:stable-slim

ADD ./scripts/ /usr/local/bin/

RUN apt-get update && apt-get install -y \
    aria2 \
    rsync \
    && rm -rf /var/lib/apt/lists/*