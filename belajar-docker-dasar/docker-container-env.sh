docker image pull mongo:latest

docker container create --name contohmongo --publish 27017:27017 --env MONGO_INITDB_ROOT_USERNAME=helmipradita --env MONGO_INITDB_ROOT_PASSWORD=helmipradita mongo:latest