# PZN Docker — Belajar Docker dari Nol

> **Repository:** [github.com/z0nk/pzn-docker](https://github.com/z0nk/pzn-docker)
>
> **Author:** Helmi Pradita
>
> **Deskripsi:** Projek belajar Docker dari fundamental hingga intermediate — mencakup Docker CLI, Dockerfile, dan Docker Compose. Setiap materi dipisah dalam 3 modul utama dengan contoh langsung yang bisa dijalankan.

---

## 📦 Modul 1: `belajar-docker-dasar/` — Docker Fundamentals

25+ shell script yang mendemonstrasikan perintah-perintah dasar Docker CLI. Setiap file adalah satu topik spesifik dan bisa dieksekusi langsung.

```mermaid
flowchart LR
    subgraph CLI[Docker CLI Operations]
        direction TB
        A[docker container] --> B[create / start / stop / rm]
        C[docker image] --> D[pull / ls / rm / prune]
        E[docker network] --> F[create / connect / disconnect]
        G[docker volume] --> H[create / mount / ls]
    end

    subgraph Run[Container Runtime]
        I[Port Mapping] --> J["-p 8080:80"]
        K[Environment] --> L["--env KEY=VALUE"]
        M[Bind Mounts] --> N["--mount type=bind"]
        O[Volumes] --> P["--mount type=volume"]
    end

    subgraph Inspect[Observation]
        Q[docker logs] --> R[-f follow mode]
        S[docker exec] --> T[-i -t interactive]
        U[docker stats]
        V[docker inspect]
    end

    CLI --> Run --> Inspect
```

### Topik yang dipelajari

| File | Perintah | Konsep |
|------|----------|--------|
| `docker-container.sh` | `create`, `start`, `stop`, `rm` | Siklus hidup container |
| `docker-image.sh` | `pull`, `ls`, `rm` | Manajemen image |
| `docker-container-port.sh` | `--publish` | Port forwarding host → container |
| `docker-container-env.sh` | `--env` | Environment variables untuk konfigurasi |
| `docker-container-logs.sh` | `logs`, `logs -f` | Melihat output container |
| `docker-container-exec.sh` | `exec -i -t` | Masuk ke container interactive |
| `docker-container-stats.sh` | `stats` | Monitoring resource container |
| `docker-container-network.sh` | `network create`, `connect`, `disconnect` | Isolasi jaringan antar container |
| `docker-container-volume.sh` | `volume create`, `--mount type=volume` | Persistent data dengan named volume |
| `docker-bind-mounts.sh` | `--mount type=bind` | Mount direktori host ke container |
| `docker-prune.sh` | `system prune`, `volume prune`, `network prune` | Cleanup resource Docker |

### Contoh penggunaan

```bash
# Container nginx dengan port mapping
docker container create --name contohnginx --publish 8080:80 nginx:latest
docker container start contohnginx
curl localhost:8080

# MongoDB dengan network dan auth
docker container create --name mongodb --network mongonetwork \
  --env MONGO_INITDB_ROOT_USERNAME=helmipradita \
  --env MONGO_INITDB_ROOT_PASSWORD=helmipradita \
  mongo:latest
```

---

## 🔨 Modul 2: `belajar-docker-dockerfile/` — Dockerfile Instruction

16 sub-direktori, masing-masing berisi satu Dockerfile yang mendemonstrasikan satu instruksi Dockerfile spesifik. Setiap Dockerfile bisa di-build dan di-run untuk melihat efek instruksi tersebut.

```mermaid
graph LR
    subgraph Build[Build Stage]
        A[FROM] --> B[WORKDIR]
        B --> C[ARG]
        C --> D[LABEL]
        D --> E[COPY / ADD]
        E --> F[RUN]
    end

    subgraph Config[Configuration]
        G[ENV]
        H[EXPOSE]
        I[VOLUME]
        J[USER]
    end

    subgraph Runtime[Runtime Stage]
        K[CMD]
        L[ENTRYPOINT]
        M[HEALTHCHECK]
    end

    Build --> Config --> Runtime
```

### Daftar Instruksi

| Folder | Instruksi | Apa yang dipelajari |
|--------|-----------|-------------------|
| `from/` | `FROM` | Memilih base image (alpine, golang) |
| `run/` | `RUN` | Mengeksekusi perintah saat build (mkdir, echo) |
| `cmd/` | `CMD` | Default perintah saat container start |
| `label/` | `LABEL` | Metadata image (author, company, website) |
| `add/` | `ADD` | Copy file + wildcard + tar/URL support |
| `copy/` | `COPY` | Copy file dari context (lebih eksplisit dari ADD) |
| `ignore/` | `.dockerignore` | Mengecualikan file dari build context |
| `expose/` | `EXPOSE` | Mendokumentasikan port container |
| `env/` | `ENV` | Environment variable yang bisa di-override runtime |
| `volume/` | `VOLUME` | Mendeklarasikan mount point untuk persistent data |
| `workdir/` | `WORKDIR` | Mengubah working directory (inherit dari base image) |
| `user/` | `USER` | Menjalankan container sebagai non-root user |
| `arg/` | `ARG` | Build-time variable dengan `--build-arg` |
| `health/` | `HEALTHCHECK` | Health check endpoint monitoring container |
| `entrypoint/` | `ENTRYPOINT` + `CMD` | Fixed executable + default arguments pattern |
| `multi/` | Multi-stage Build | Builder pattern: build di golang → run di alpine |

### Catatan penting

- **COPY vs ADD:** Gunakan `COPY` untuk file lokal, `ADD` hanya jika perlu ekstraksi tar otomatis atau URL
- **WORKDIR** bersifat inherited: base image `golang:1.18-alpine` punya `WORKDIR /go`, sehingga CMD harus full path atau tulis ulang `WORKDIR`
- **CMD vs ENTRYPOINT:** `CMD` bisa di-override saat `docker run`, `ENTRYPOINT` gak bisa tanpa `--entrypoint`
- **ARG vs ENV:** `ARG` hanya ada saat build, `ENV` tersedia di container runtime
- **Multi-stage** mengurangi ukuran final image drastis (contoh: `119MB → 7.43MB`)

### Contoh Dockerfile — Multi-stage Build

```dockerfile
FROM golang:1.18-alpine AS builder
WORKDIR /app/
COPY main.go /app/
RUN go build -o /app/main /app/main.go

FROM alpine:3
WORKDIR /app/
COPY --from=builder /app/main /app/
CMD /app/main
```

---

## 🐳 Modul 3: `belajar-docker-compose/` — Docker Compose

12 sub-direktori yang mendemonstrasikan fitur-fitur Docker Compose dari paling sederhana hingga multi-file override.

```mermaid
graph TB
    subgraph Compose[Docker Compose Features]
        direction TB
        A[services/] --> B[Multi-service definition]
        C[example/] --> D[Minimal compose example]
        E[ports/] --> F[Long syntax port mapping]
        G[environments/] --> H[Environment variables]
        I[networks/] --> J[Custom bridge network]
        K[volumes/] --> L[Named volumes management]
    end

    subgraph Advanced[Advanced Features]
        M[bind-mount/] --> N[Host directory bind mount]
        O[build/] --> P[Build image via compose]
        Q[depends-on/] --> R[Service startup order]
        S[health-check/] --> T[Container healthcheck]
        U[extend-service/] --> V[Multi-file compose override]
        W[resource-limit/] --> X[CPU/Memory constraints]
    end

    Compose --> Advanced
```

### Daftar Topik

| Folder | Konsep | File Kunci |
|--------|--------|------------|
| `yaml/` | Belajar format YAML untuk compose | `user.yaml` |
| `services/` | Definisi multi-service (nginx + mongo) | `docker-compose.yaml` |
| `example/` | Contoh minimal 2 service nginx | `docker-compose.yaml` |
| `ports/` | Long syntax port mapping `protocol:published:target` | `docker-compose.yml` |
| `environments/` | Environment variable via compose | `docker-compose.yaml` |
| `networks/` | Custom bridge network antar service | `docker-compose.yaml` |
| `volumes/` | Named volume dengan syntax panjang/pendek | `docker-compose.yaml` |
| `bind-mount/` | Bind mount host directory dengan 2 cara | `docker-compose.yaml` |
| `build/` | Build image dari Dockerfile via compose | `docker-compose.yaml` + `app/Dockerfile` |
| `depends-on/` | Urutan startup service (`depends_on`) | `docker-compose.yaml` |
| `health-check/` | Health check di level compose | `docker-compose.yaml` |
| `extend-service/` | Override config: `local.yaml`, `dev.yaml`, `prod.yaml` | 4 compose files |
| `resource-limit/` | CPU & memory reservation/limit | `docker-compose.yaml` |

### Contoh compose — MongoDB + Mongo Express

```yaml
services:
  mongodb-example:
    image: mongo:latest
    container_name: mongodb-example
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_ROOT_USERNAME: helmipradita
      MONGO_INITDB_ROOT_PASSWORD: helmipradita
    networks:
      - network_example

  mongodb-express-example:
    image: mongo-express:latest
    container_name: mongodb-express-example
    ports:
      - "8081:8081"
    environment:
      ME_CONFIG_MONGODB_URL: mongodb://helmipradita:helmipradita@mongodb-example:27017/admin
    depends_on:
      - mongodb-example
    networks:
      - network_example

networks:
  network_example:
    name: network_example
    driver: bridge
```

### Extend Service Pattern

Override konfigurasi sesuai environment dengan merge file compose:

```bash
# Local
docker compose -f docker-compose.yaml -f local.yaml up -d

# Dev
docker compose -f docker-compose.yaml -f dev.yaml up -d

# Production
docker compose -f docker-compose.yaml -f prod.yaml up -d
```

---

## 🚀 Quick Start

```bash
# 1. Belajar Docker CLI dasar
cd belajar-docker-dasar
bash docker-container.sh
bash docker-image.sh

# 2. Build dan run Dockerfile examples
cd ../belajar-docker-dockerfile
bash script.sh

# 3. Run Docker Compose stacks
cd ../belajar-docker-compose/services
docker compose up -d
docker compose ps
docker compose down
```

## 📁 Struktur Projek

```
pzn-docker/
├── README.md                           ← Kamu disini
├── belajar-docker-dasar/               ← 17 shell script Docker CLI
│   ├── docker-container.sh
│   ├── docker-container-network.sh
│   ├── docker-container-volume.sh
│   ├── docker-bind-mounts.sh
│   └── ... (12 script lainnya)
│
├── belajar-docker-dockerfile/          ← 16 folder Dockerfile
│   ├── from/Dockerfile
│   ├── multi/Dockerfile
│   ├── health/Dockerfile
│   ├── entrypoint/Dockerfile
│   └── ... (12 folder lainnya)
│
└── belajar-docker-compose/             ← 12 folder Docker Compose
    ├── services/docker-compose.yaml
    ├── networks/docker-compose.yaml
    ├── volumes/docker-compose.yaml
    ├── build/docker-compose.yaml
    ├── extend-service/
    └── ... (7 folder lainnya)
```

---

> Dibuat untuk pembelajaran pribadi oleh [Helmi Pradita](https://helmipradita.dev/)
