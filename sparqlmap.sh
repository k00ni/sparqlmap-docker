#!/bin/bash

# these 2 guys force the bash to execute this script under strict rules.
# that means, fail asap, if something weird happens, like an unbound variable.
set -euo pipefail
IFS=$'\n\t'

DATA_DIR="/sparqlmap-data"
LOG_DIR="/sparqlmap-data"
LOG_FILE_NAME="sparqlmap.log"

# remove existing log
rm -rf /sparqlmap-log/sparqlmap.log

echo
echo "Running sparqlmap ..."
echo

./sparqlmap/bin/sparqlmap \
    --action=$ACTION \
    --ds.url=$DATA_DIR/$INPUT_FILE \
    --ds.type=$DATASOURCE_TYPE \
    --ds.separatorChar=$CSV_SEPARATOR \
    --r2rmlfile=$DATA_DIR/$MAPPING_FILE \
    1>> /sparqlmap-data/$OUTPUT_FILE \
    2>> /sparqlmap-log/$LOG_FILE_NAME

echo
echo "Sparqlmap is done, reduce file size of " $OUTPUT_FILE
echo
# as long as https://github.com/tomatophantastico/sparqlmap/issues/34 is open
# we reduce generated file using rapper (size reduced by about 80%)
rapper -i turtle -o turtle /sparqlmap-data/$OUTPUT_FILE > /tmp/$OUTPUT_FILE
rm /sparqlmap-data/$OUTPUT_FILE
mv /tmp/$OUTPUT_FILE /sparqlmap-data/$OUTPUT_FILE

# root owns this file, so we have to make it accessible to the outside world
chmod 0777 /sparqlmap-data/$OUTPUT_FILE
