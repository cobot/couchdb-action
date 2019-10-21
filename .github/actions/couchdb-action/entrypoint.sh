#!/bin/sh

sh -c "docker run -d -p 5984:5984 couchdb:$INPUT_COUCHDB_VERSION"