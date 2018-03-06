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
