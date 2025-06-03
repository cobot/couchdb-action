#!/bin/sh

wait_for_couchdb() {
  echo "Waiting for CouchDB..."
  hostip=$(ip route show | awk '/default/ {print $3}')
  echo "CouchDB host IP: $hostip"
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

echo "CouchDB is up and running."