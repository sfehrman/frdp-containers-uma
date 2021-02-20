#!/bin/bash

export HOST_NAME="as.example.com"
export HOST_PORT="8080"
export BASE_URL="http://${HOST_NAME}:${HOST_PORT}/am"
export AUTHEN_URL="${BASE_URL}/json/realms/root/authenticate"
export USER_URL="${BASE_URL}/json/realms/root/users"
export USER_NAME="amadmin"
export USER_PASS="password"

# get a SSO token for the admin user

echo "Getting SSO Token"
export SSO_TOKEN=`curl -s -X POST -H "X-OpenAM-Username: ${USER_NAME}" -H "X-OpenAM-Password: ${USER_PASS}" -H "Accept-API-Version: resource=2.0, protocol=1.0" ${AUTHEN_URL} | cut -f2 -d: | cut -f1 -d, | sed -e 's/"//g'`

# create user, resource owner

echo "Adding user 'dcrane', Resource Owner"

curl ${USER_URL}/dcrane \
-X 'PUT' \
-s \
-H 'Accept-API-Version: protocol=2.0,resource=4.0' \
-H 'Content-Type: application/json' \
-H "iPlanetDirectoryPro: ${SSO_TOKEN}" \
--data-raw '{"cn":"Danny Crane (RO)","sn":"Crane","mail":"dcrane@example.com","givenName":"Danny","inetUserStatus":"Active","userPassword":"Uma-1234"}'

echo ""

# create user, requesting party

echo "Adding user 'bjensen' Requesting Party"

curl ${USER_URL}/bjensen \
-X 'PUT' \
-s \
-H 'Accept-API-Version: protocol=2.0,resource=4.0' \
-H 'Content-Type: application/json' \
-H "iPlanetDirectoryPro: ${SSO_TOKEN}" \
--data-raw '{"cn":"Barb Jensen (RqP)","sn":"Jensen","mail":"bjensen@example.com","givenName":"Barb","inetUserStatus":"Active","userPassword":"Uma-1234"}'

echo ""