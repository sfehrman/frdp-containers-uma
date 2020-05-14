# frdp-containers-uma

ForgeRock Demonstration Platform (FRDP) : **UMA Containers** : Is a project that provides a *Ready-2-Run* environment for testing the User-Managed Access (UMA) Reference Implementation.  The project requires [`docker` and `docker-compose`](http://docs.docker.com) technologies.  The [Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/) was used for this project.

`git clone https://github.com/ForgeRock/frdp-containers-uma.git`


# Disclaimer

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# License

[MIT](/LICENSE)

# Requirements

## Docker

Install [**docker**](https://docs.docker.com/get-started/) on your desktop

## ForgeRock Access Manager / Amster

This project uses the ForgeRock Access Manager 6.5.2 which provides User-Manager Access (UMA) Authorization Server functionality. The ForgeRock Amster utility is used to automate the configuration of Access Manager.  Access Manager and Amster can be download from the ForgeRock [backstage](https://backstage.forgerock.com/downloads/browse/am/latest) web site.  

**NOTICE:** You need an account to access the ForgeRock backstage resources.

1. Download the **Access Manager** zip file and save it to a temporary location.
1. From the temporary Access Manager location, expanded zip file 
1. From the temporary Access Manager location ...\
Copy the `openam/AM-6.5.2.x.war` file to: \
`containers/auth-server/docker/build/resources/am.war`
1. Download the **Amster** zip file and save it to a temporary location.
1. Copy the `Amster-6.5.2.x.zip` file to: \
`containers/auth-server/docker/build/resources/amster.zip`

# Setup

## hostnames

You must add the following aliases to the `/etc/hosts` file entry: `127.0.0.1   localhost`
- `as.example.com`
- `rs.example.com`

### For MacOS

```bash
sudo vi /etc/hosts
```
Change the `127.0.0.1` line: \
**BEFORE**
```bash
127.0.0.1       localhost
```
**AFTER**
```bash
127.0.0.1       localhost as.example.com rs.example.com
```
## Environment variables

The following environment variable are used and **must** be set:

- `AM_HOST`
- `AM_PASSWORD`

Open a terminal and run the following commands:

```bash
export AM_HOST=as.example.com
export AM_PASSWORD=password
```

# Run

Make sure your terminal session has the environment variables set *(see above)*

Use the `docker-compose` command the run Docker containers:

```bash
docker-compose up --build
```

# Verify

## Docker

After the *build* process is complete, check that the containers are running.  Open another terminal and run `docker ps`:

```bash
docker ps

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                      NAMES
55b21cf3050c        uma-rs              "catalina.sh run"        29 seconds ago      Up 28 seconds       0.0.0.0:8090->8080/tcp     uma-rs
3024a33fab15        uma-cs              "catalina.sh run"        30 seconds ago      Up 29 seconds       0.0.0.0:8085->8080/tcp     uma-cs
240022b09471        uma-as              "catalina.sh run"        30 seconds ago      Up 29 seconds       0.0.0.0:8080->8080/tcp     uma-as
be18f3fcf73f        uma-db              "docker-entrypoint.s…"   30 seconds ago      Up 29 seconds       0.0.0.0:27017->27017/tcp   uma-db
```
## Authorization Server

Log into the Authorization Server as the two test users. Open browser and access ... `http://as.example.com/8080/am`

| User | Password | First name | Last name | UMA operations |
| ---- | -------- | ---------- | --------- | -------------- |
| `dcrane` | `password` | Danny | Crane | Resource Owner |
| `bjensen` | `password` | Barb | Jensen | Requesting Party |

- From the top toolbar
- Select **SHARES** drop down menu
- Select **RESOURCES** menu item
- From Left Menu ...\
**My Resource** displays the user's registered UMA resources \
**Shared with Me** displays resource's the user can access

# Testing

To test the UMA environment, [**postman**](https://www.postman.com/downloads/) collections have been provided.  Start `postman` and load the *environment* json file an the two *collection* json files:

- `postman/RS.postman_environment,json`
- `postman/RO.postman_collection.json`
- `postman/RqP.postman_collection.json`

See the following instructions for **Resource Owner** and **Requesting Party** use cases.  Note: the use case instructions reference the use of *default* `postman` files ... skip this step, use the `postman` files in this project ... the environment has been pre-configured.

- [Resoure Owner](https://github.com/ForgeRock/frdp-uma-resource-server/blob/master/testing/RO/README.md)
- [Requesting Party](https://github.com/ForgeRock/frdp-uma-resource-server/blob/master/testing/RqP/README.md)

# Reference

## Properties

| Name | Value |
| ---- | ----- |
| Domain Name | `example.com` |
| AM_HOST | `as.example.com` |
| AM_PASSWORD | `password` |

## Images / Containers

| Description | Hostname | Image Name | Container Name | Host Port | Container Port |
| ----------- | -------- | ----- | --------- | -------- | ---- |
| Authorization Server | `as`    | `uma-as`    | `uma-as`    | `8080` | `8080`
| Mongo Database       | `db`    | `uma-db`    | `uma-db`    | `27017` | `27017`
| Content Server       | `cs`    | `uma-cs`    | `uma-cs`    | `8085` | `8080`
| Resource Server      | `rs`    | `uma-rs`    | `uma-rs`    | `8090` | `8080`
