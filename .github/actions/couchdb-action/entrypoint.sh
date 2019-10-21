#!/bin/sh

echo "Starting Docker..."
sh -c "docker run -d -p 5984:5984 couchdb:$INPUT_COUCHDB_VERSION"
echo "Started Docker..."
echo "Waiting for CouchDB..."
sleep 10
echo "done."
echo "Checking CouchDB:"
curl -i http://couchdb:5984/
