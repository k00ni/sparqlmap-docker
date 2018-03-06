# sparqlmap-docker

Docker to run sparqlmap to transform a CSV file to RDF file.

## build and run

Just run the following command in the folder:

```
docker-compose up --build
```

## data and log

Add a `input.csv` file as input and a `mapping.ttl` R2RML mapping file to the `data` folder. The docker will take this automatically and will put a `output.ttl` in data folder after it finished successfully.

The `log` folder will contain a `sparqlmap.log` file after sparqlmap ran.

## integration

You can adapt the `docker-compose.yml` in case you want to change some internals or to integrate the container in a larger setup. Transformation magic is located in `sparqlmap.sh`.
