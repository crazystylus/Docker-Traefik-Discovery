# Docker Discovery with Traefik
## Repo Structure
```
.
├── app                 Go Application
│   ├── go.mod          Go Module
│   ├── go.sum          Go dependency checksum
│   └── main.go         Main Package
├── docker-compose.yaml Docker Compose File to start Traefik
├── Dockerfile          Go API Dockerfile
├── labels.sh           Generates docker labels for API Versioning
├── LICENSE             License
└── Readme.md           This file
```

## Introduction
This demo showcases usefulness of Traefik autodiscovery with Docker and how we can have API versioning by controlling Traefik through docker labels. When we work and create containers with Docker in local env, we necessarily don't have the same setup as we have in production environment with Kubernetes as orchestration platform and an API Gateway like Istio. One way to do the same in local env is to create a similar sandbox env or create a API Gateway simply out of nginx and manually configure it. There is a simple way out here.

Traefik comes with autodiscovery support for Docker. Configuring things like Entrypoint, Middlewares and Rules can be simply done by specifying labels while creating containers in docker.

## Requirements
1. Docker - Building and running containers
2. Docker Compose - Running Traefik
3. curl - Verifying the APIs
4. sed - String manipulation and substituation
5. 2 Free Ports - docker-compose.yaml uses 8080 and 8081, if already in use please substitute them

## Getting Started
### Building the container image
```bash
git clone https://github.com/crazystylus/Docker-Traefik-Discovery.git
cd Docker-Traefik-Discovery
docker build . -t myapi:v1
```

### Starting Traefik
```bash
docker-compose up -d traefik
```

### Starting various API versions
```bash
for APIVERSION in {1..6};
do
    docker run -d $(./labels.sh) -e APIVERSION=${APIVERSION} -p 8080 --rm myapi:v1;
done;
```

### Testing all APIs
```bash
for i in {1..6};
do
    curl http://localhost:8081/myapi/v${i}/
done
```
## Cleanup
### Removing the 6 APIs we created
```bash
docker rm -f $(docker ps --filter "ancestor=myapi:v1" -q)
```
**NOTE** This will remove all containers running the image myapi:v1 which build and used in this demo

### Stopping Traefik
```bash
docker-compose down
```
**NOTE** For this to work you need to be present in the folder with docker-compose.yaml