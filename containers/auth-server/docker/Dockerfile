# Dockerfile : Authorization Server

# Get a container (tomcat) for the application, include arguments

FROM tomcat:9-jdk11-adoptopenjdk-hotspot
ARG AM_HOST=${AM_HOST}
ARG AM_PASSWORD=${AM_PASSWORD}

# Add OS tools we need

# RUN apk add curl
RUN apt-get update -y && \
    apt-get install -y binutils wget unzip curl

# Remove existing applications

RUN rm -rf "$CATALINA_HOME"/webapps/*

# Add AM and Amster products

ADD build/resources/am.war "$CATALINA_HOME"/webapps/am.war
ADD build/resources/amster.zip /tmp/amster.zip

# add amster configuration

RUN mkdir -p /opt/forgerock/amster && \
    unzip -q /tmp/amster.zip -d /opt/forgerock/amster

ADD build/amster/install-am.amster /opt/forgerock/amster/install-am.amster
ADD build/amster/import-config.amster /opt/forgerock/amster/import-config.amster
ADD build/amster/export-config.amster /opt/forgerock/amster/export-config.amster
ADD build/amster/am-config /opt/forgerock/am/configuration
ADD build/amster/am-snapshot /opt/forgerock/am/snapshot

# deploy shell commands

ADD build/users.sh /opt/forgerock/am/users.sh
ADD build/commands.sh /opt/forgerock/am/commands.sh
RUN chmod a+x /opt/forgerock/am/commands.sh /opt/forgerock/am/users.sh
RUN /bin/bash -c "echo \"source /opt/forgerock/am/commands.sh\" >> /root/.bashrc"

# Install AM

RUN /bin/bash -c \
    "source /opt/forgerock/am/commands.sh && install_am && configure_am && load_users && stop_tomcat"

# run tomcat

CMD [ "catalina.sh", "run" ]