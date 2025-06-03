FROM docker:stable
RUN apk add --no-cache curl sed

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]