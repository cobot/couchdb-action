FROM docker:stable
RUN apk add --no-cache curl
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]