# Dockerfile : Content Server : builds from source files in Git Hub

# Get a container (maven) for compiling source code

FROM maven:3-openjdk-11 AS build  

# Get the required projects from github

RUN git clone --branch 1.2.0 --progress --verbose https://github.com/ForgeRock/frdp-framework 
RUN git clone --branch 1.2.1 --progress --verbose https://github.com/ForgeRock/frdp-dao-mongo
RUN git clone --branch 1.2.2 --progress --verbose https://github.com/ForgeRock/frdp-content-server

# run maven (mvn) to compile jar files and package the war file

RUN cd frdp-framework 
WORKDIR "/frdp-framework"
RUN mvn compile install 
WORKDIR "/frdp-dao-mongo"
RUN mvn verify clean --fail-never install
WORKDIR "/frdp-content-server"
RUN mvn verify clean --fail-never package 

# Get a container (tomcat) to run the application

FROM tomcat:9-jdk11-adoptopenjdk-hotspot

# Remove default applicatons

RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the expanded application folder

COPY --from=build /frdp-content-server/target/content-server /usr/local/tomcat/webapps/content-server

# Add configuration file to the proper folder

ADD tomcat/webapps/content-server/WEB-INF/config/content-server.json /usr/local/tomcat/webapps/content-server/WEB-INF/config/content-server.json

CMD ["catalina.sh", "run"]
