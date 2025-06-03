FROM docker:stable
RUN apk add --no-cache curl sed

COPY Dockerfile.couchdb /Dockerfile.couchdb
COPY entrypoint.sh /entrypoint.sh
COPY 01-github-action-custom.ini /local.d/01-github-action-custom.ini

ENTRYPOINT ["/entrypoint.sh"]