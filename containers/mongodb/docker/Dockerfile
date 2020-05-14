FROM mongo:3.2

ENV MONGO_INITDB_ROOT_USERNAME=root
ENV MONGO_INITDB_ROOT_PASSWORD=password

COPY initdb.js /docker-entrypoint-initdb.d
