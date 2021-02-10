FROM docker:stable
RUN apk add --no-cache curl

RUN mkdir -p /opt/couchdb/etc/local.d && echo "[couchdb]\ndatabase_dir = /ram_disk\nview_index_dir = /ram_disk\ndelayed_commits = true\n[httpd]\nsocket_options = [{nodelay, true}]\n[native_query_servers]\nerlang = {couch_native_process, start_link, []}" >> /opt/couchdb/etc/local.d/01-github-action-custom.ini

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]