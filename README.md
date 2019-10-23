# CouchDB GitHub Action

This [GitHub Action](https://github.com/features/actions) sets up a CouchDB database.

# Usage

See [action.yml](action.yml) and [test.yml](.github/workflows/test.yml).

Basic:
```yaml
steps:
  - name: Set up CouchDB
    id: couchdb
    uses: "cobot/couchdb-action@master"
    with:
      couchdb version: '2.3.1'
  - name: Do something
    run: |
      curl http://${{steps.couchdb.outputs.ip}}:5984/

```

# Contributions

- [Cobot](https://www.cobot.me)
- [CouchDB @ Neighbourhoodie Software](https://neighbourhood.ie/couchdb-support/)

# License

The scripts and documentation in this project are released under the [MIT License](LICENSE)
