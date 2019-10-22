#!/bin/sh

echo "Starting Docker..."
sh -c "docker run -d -p 5984:5984 -p 5986:5986 couchdb:$INPUT_COUCHDB_VERSION"
echo "Waiting for CouchDB..."
sleep 10
echo "Checking CouchDB is running:"
hostip=$(ip route show | awk '/default/ {print $3}')
curl -vi http://$hostip:5984/

# CouchDB container name
export NAME=`docker ps --format "{{.Names}}" --last 1`

# Set up system databases
docker exec $NAME curl 'http://127.0.0.1:5984/_users' -X PUT -H 'Content-Type: application/json' --data '{"id":"_users","name":"_users"}'
docker exec $NAME curl 'http://127.0.0.1:5984/_global_changes' -X PUT -H 'Content-Type: application/json' --data '{"id":"_global_changes","name":"_global_changes"}'
docker exec $NAME curl 'http://127.0.0.1:5984/_replicator' -X PUT -H 'Content-Type: application/json' --data '{"id":"_replicator","name":"_replicator"}'

echo ::set-output name=ip::$hostip