docker network ls

docker network create --driver bridge mongonetwork

docker container create --name mongodb --network mongonetwork --env MONGO_INITDB_ROOT_USERNAME=helmipradita --env MONGO_INITDB_ROOT_PASSWORD=helmipradita mongo:latest

docker image pull mongo-express:latest

docker container create --name mongodbexpress --network mongonetwork --publish 8081:8081 --env ME_CONFIG_MONGODB_URL="mongodb://helmipradita:helmipradita@mongodb:27017/" mongo-express:latest

docker container start mongodb

docker container start mongodbexpress

```ui
username: admin
password: pass
```

docker network disconnect mongonetwork mongodb

docker network connect mongonetwork mongodb