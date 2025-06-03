#!/bin/sh

wait_for_couchdb() {
  echo "Waiting for CouchDB..."
  retries=0
  max_retries=20

  while ! curl -f http://127.0.0.1:5984/ &> /dev/null
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