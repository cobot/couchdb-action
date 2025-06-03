#!/bin/sh

echo "Starting Docker..."
sed -i "s/COUCHDB_VERSION/$INPUT_COUCHDB_VERSION/" /work/Dockerfile.couchdb
docker build --tag couchdb -f /work/Dockerfile.couchdb .
docker run -d -p 5984:5984 -p 5986:5986 --tmpfs /ram_disk couchdb

# CouchDB container name
export NAME=`docker ps --format "{{.Names}}" --last 1`

wait_for_couchdb() {
  echo "Waiting for CouchDB..."
  hostip=$(ip route show | awk '/default/ {print $3}')
  retries=0
  max_retries=20

  while ! curl -f http://$hostip:5984/ &> /dev/null
  do
    retries=$((retries+1))
    if [ $retries -ge $max_retries ]; then
      echo "CouchDB did not become available after $max_retries attempts. Exiting."
      exit 1
    fi
    echo "."
    sleep 1
  done
}
wait_for_couchdb

# Set up system databases
echo "Setting up CouchDB system databases..."
docker exec $NAME curl -sS 'http://admin:admin@127.0.0.1:5984/_users' -X PUT -H 'Content-Type: application/json' --data '{"id":"_users","name":"_users"}' > /dev/null
docker exec $NAME curl -sS 'http://admin:admin@127.0.0.1:5984/_global_changes' -X PUT -H 'Content-Type: application/json' --data '{"id":"_global_changes","name":"_global_changes"}' > /dev/null
docker exec $NAME curl -sS 'http://admin:admin@127.0.0.1:5984/_replicator' -X PUT -H 'Content-Type: application/json' --data '{"id":"_replicator","name":"_replicator"}' > /dev/null
