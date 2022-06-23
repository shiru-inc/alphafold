FROM alpine:3

ADD ./scripts/ /usr/local/bin/

RUN apk add --update --no-cache aria2 bash && rm -rf /var/cache/apk/*