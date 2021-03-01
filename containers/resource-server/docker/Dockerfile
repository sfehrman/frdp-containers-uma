# Dockerfile : Resource Server

# Get a container (maven) for compiling source code

FROM maven:3-openjdk-11 AS build  

# Get the required projects from github

RUN git clone --branch 1.2.0 --progress --verbose https://github.com/ForgeRock/frdp-framework 
RUN git clone --branch 1.2.0 --progress --verbose https://github.com/ForgeRock/frdp-dao-mongo
RUN git clone --branch 1.2.0 --progress --verbose https://github.com/ForgeRock/frdp-dao-rest 
RUN git clone --branch 1.2.0 --progress --verbose https://github.com/ForgeRock/frdp-uma-resource-server 

# run maven (mvn) to compile jar files and package the war file

RUN cd frdp-framework 
WORKDIR "/frdp-framework"
RUN mvn compile install 
WORKDIR "/frdp-dao-mongo"
RUN mvn verify clean --fail-never install
WORKDIR "/frdp-dao-rest"
RUN mvn verify clean --fail-never install 
WORKDIR "/frdp-uma-resource-server"
RUN mvn verify clean --fail-never package 

# Get a container (tomcat) for the application

FROM tomcat:9-jdk11-adoptopenjdk-hotspot

# Remove default applicatons

RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the expanded application folder

COPY --from=build /frdp-uma-resource-server/target/resource-server "$CATALINA_HOME"/webapps/resource-server

# Add configuration file to the proper folder (add logging.properties for debugging)

# ADD tomcat/conf/logging.properties "$CATALINA_HOME"/conf
ADD tomcat/webapps/resource-server/WEB-INF/config/*.json /usr/local/tomcat/webapps/resource-server/WEB-INF/config/

# Expose port: default = (host:containr) 8090:8080, java debugger = 9000:8000

EXPOSE 8090:8080
# EXPOSE 9000:8000

# Environment variables for attaching Java debugger

# ENV JPDA_ADDRESS="8000"
# ENV JPDA_TRANSPORT="dt_socket"

# Command to run ... "jpda" is for the java debugger

# CMD ["catalina.sh", "jpda", "run"]
CMD ["catalina.sh", "run"]
