FROM java

# variables
ARG MAIN_FOLDER=/sparqlmap
ENV MAIN_FOLDER=${MAIN_FOLDER}
ARG SPARQLMAP_FOLDER=$MAIN_TOOLS_FOLDER/sparqlmap
ARG SPARQLMAP_FILE=sparqlmap-client-0.7.5-SNAPSHOT
ARG SPARQLMAP_TESTDATA_FOLDER=$MAIN_TESTDATA_FOLDER/sparqlmap
ARG SPARQLMAP_DOWNLOAD=https://github.com/tomatophantastico/sparqlmap/releases/download/v0.7.5-SNAPSHOT-2/$SPARQLMAP_FILE.zip
ARG MYSQL_CONNECTOR_FILE=mysql-connector-java-5.1.44

# get and setup sparqlmap
RUN cd /tmp && wget $SPARQLMAP_DOWNLOAD
RUN cd /tmp && unzip $SPARQLMAP_FILE.zip -d /tmp
RUN rm /tmp/$SPARQLMAP_FILE.zip

RUN mkdir /tmp/sparqlmap
RUN mkdir /tmp/sparqlmap/lib
RUN mkdir /tmp/sparqlmap-log
RUN mkdir /tmp/sparqlmap-data

# add mysql library to sparqlmap/lib
RUN cd /tmp/ && wget http://cdn.mysql.com//Downloads/Connector-J/$MYSQL_CONNECTOR_FILE.tar.gz
RUN cd /tmp/ && tar xf $MYSQL_CONNECTOR_FILE.tar.gz -C /tmp
RUN cp \
    /tmp/$MYSQL_CONNECTOR_FILE/$MYSQL_CONNECTOR_FILE-bin.jar \
    /tmp/sparqlmap/lib/$MYSQL_CONNECTOR_FILE-bin.jar

# finalize sparqlmap
RUN mv /tmp/$SPARQLMAP_FILE /sparqlmap

# script to call sparqlmap
COPY ./sparqlmap.sh /sparqlmap.sh
RUN chmod +x /sparqlmap.sh

CMD ["/sparqlmap.sh"]
