#!/bin/sh

echo "Starting Docker..."
sh -c "docker run -d -p 5984:5984 -p 5986:5986 couchdb:$INPUT_COUCHDB_VERSION"
echo "Started Docker..."
echo "Waiting for CouchDB..."
sleep 20
echo "done."
docker ps
export NAME=`docker ps --format "{{.Names}}" --last 1`
docker top $NAME
docker logs $NAME
echo "Checking CouchDB:"
curl -i http://localhost:5986/
