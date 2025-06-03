FROM docker:stable
RUN apk add --no-cache curl sed

RUN mkdir -p /work
WORKDIR /work

COPY Dockerfile.couchdb /work/
COPY entrypoint.sh /work/
COPY 01-github-action-custom.ini /work/

ENTRYPOINT ["/work/entrypoint.sh"]