# FROM Instruction
docker build -t helmipradita/from from

docker image ls

# RUN Instruction
docker build -t helmipradita/run run

docker build -t helmipradita/run run --progress=plain --no-cache

# CMD Instruction
docker build -t helmipradita/command command

docker image inspect helmipradita/command

docker container create --name command helmipradita/command

docker container start command

docker container logs command

# LABEL Instruction
docker build -t helmipradita/label label

docker image inspect helmipradita/label

# ADD Instruction
docker build -t helmipradita/add add

docker container create --name add helmipradita/add

docker container start add

docker container logs add

# COPY Instruction
docker build -t helmipradita/copy copy

docker container create --name copy helmipradita/copy

docker container start copy

docker container logs copy

# .dockerignore
docker build -t helmipradita/ignore ignore

docker container create --name ignore helmipradita/ignore

docker container start ignore

docker container logs ignore

# EXPOSE Instruction
docker build -t helmipradita/expose expose

docker image inspect helmipradita/expose

docker container create --name expose -p 8080:8080 helmipradita/expose

docker container start expose

curl localhost:8080

docker container ls

docker container stop expose

# ENV Instruction
docker build -t helmipradita/env env

docker image inspect helmipradita/env

docker container create --name env --env APP_PORT=9090 -p 9090:9090 helmipradita/env

# docker container create --name env -p 9090:8080 helmipradita/env

docker container start env

curl localhost:9090

docker container ls

docker container logs env

docker container stop env

# VOLUME Instruction
docker build -t helmipradita/volume volume

docker image inspect helmipradita/volume

# docker container create --name volume --env APP_PORT=8090 -p 9090:8090 helmipradita/volume

docker container create --name volume -p 8080:8080 helmipradita/volume

docker container start volume

docker container logs volume

curl localhost:9090/helmi

curl localhost:9090/pradita

docker container logs volume

docker container inspect volume

#a35f6592ab4cd008dc4fde4f562ad2f546c50703b40578346de2fc987cdb7bc1

docker volume ls

# WORKDIR Instruction
docker build -t helmipradita/workdir workdir

docker container create --name workdir -p 8080:8080 helmipradita/workdir

docker container start workdir

docker container exec -i -t workdir /bin/sh