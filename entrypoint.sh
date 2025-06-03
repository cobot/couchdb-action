#!/bin/sh

echo "Starting Docker..."
sh -c "sed -i '' 's/COUCHDB_VERSION/$INPUT_COUCHDB_VERSION/' Dockerfile.couchdb"
sh -c "docker build -l warn --tag couchdb -f Dockerfile.couchdb ."
sh -c "docker run -l warn -d -p 5984:5984 -p 5986:5986 --tmpfs /ram_disk couchdb"

# CouchDB container name
export NAME=`docker ps --format "{{.Names}}" --last 1`

sleep 10

echo "CouchDB version: $INPUT_COUCHDB_VERSION"
echo "Dockerfile.couchdb: $(cat Dockerfile.couchdb)"
echo "Name: $NAME"
hostip=$(ip route show | awk '/default/ {print $3}')
echo "Host IP: $hostip"

curl -i http://$hostip:5984/


docker logs $NAME

wait_for_couchdb() {
  echo "Waiting for CouchDB..."
  hostip=$(ip route show | awk '/default/ {print $3}')

  while ! curl -f http://$hostip:5984/ &> /dev/null
  do
    echo "."
    sleep 1
  done
}
wait_for_couchdb

# Set up system databases
echo "Setting up CouchDB system databases..."
docker exec $NAME curl -sS 'http://127.0.0.1:5984/_users' -X PUT -H 'Content-Type: application/json' --data '{"id":"_users","name":"_users"}' > /dev/null
docker exec $NAME curl -sS 'http://127.0.0.1:5984/_global_changes' -X PUT -H 'Content-Type: application/json' --data '{"id":"_global_changes","name":"_global_changes"}' > /dev/null
docker exec $NAME curl -sS 'http://127.0.0.1:5984/_replicator' -X PUT -H 'Content-Type: application/json' --data '{"id":"_replicator","name":"_replicator"}' > /dev/null
