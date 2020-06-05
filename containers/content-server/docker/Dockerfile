# Dockerfile : Content Server

# Get a container (maven) for compiling source code

FROM maven:3-jdk-8 AS build  

# Get the required projects from github

RUN git clone --progress --verbose https://github.com/ForgeRock/frdp-framework 
RUN git clone --progress --verbose https://github.com/ForgeRock/frdp-dao-mongo
RUN git clone --progress --verbose https://github.com/ForgeRock/frdp-content-server

# run maven (mvn) to compile jar files and package the war file

RUN cd frdp-framework 
WORKDIR "/frdp-framework"
RUN mvn compile install 
WORKDIR "/frdp-dao-mongo"
RUN mvn verify clean --fail-never install
WORKDIR "/frdp-content-server"
RUN mvn verify clean --fail-never package 

# Get a container (tomcat) to run the application

FROM tomcat:8.5-alpine

# Remove default applicatons

RUN rm -r /usr/local/tomcat/webapps/*

# Copy the expanded application folder

COPY --from=build /frdp-content-server/target/content-server /usr/local/tomcat/webapps/content-server

# Add configuration file to the proper folder

ADD tomcat/webapps/content-server/WEB-INF/config/content-server.json /usr/local/tomcat/webapps/content-server/WEB-INF/config/content-server.json

EXPOSE 8080

CMD ["catalina.sh", "run"]
