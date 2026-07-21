docker volume create mongorestore

docker container run --rm --name ubunturestore --mount "type=bind,source=/home/z0nk/Developments/PZN/DOCKER/belajar-docker-dasar/mongo-data-backup,destination=/backup" --mount "type=volume,source=mongorestore,destination=/data" ubuntu:latest bash -c "cd /data && tar xvf /backup/backup.tar.gz --strip 1"

docker container create --name mongorestore --publish 27020:27017 --mount "type=volume,source=mongorestore,destination=/data/db" --env MONGO_INITDB_ROOT_USERNAME=helmipradita --env MONGO_INITDB_ROOT_PASSWORD=helmipradita mongo:latest

docker container start mongorestore