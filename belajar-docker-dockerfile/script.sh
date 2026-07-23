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