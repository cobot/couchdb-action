#!/bin/sh

echo "Starting Docker..."
sh -c "docker run -d -p 5984:5984 couchdb:$INPUT_COUCHDB_VERSION"
echo "Started Docker..."
echo "Waiting for CouchDB..."
sleep 20
echo "done."
docker ps
docker top lucid_mclean
echo "Checking CouchDB:"
curl -i http://localhost:5984/
