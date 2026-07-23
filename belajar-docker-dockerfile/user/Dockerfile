FROM golang:1.18-alpine

RUN mkdir /app

RUN addgroup -S helmigroup
RUN adduser -S -D -h /app helmiuser helmigroup
RUN chown -R helmiuser:helmigroup /app

USER helmiuser

COPY main.go /app

EXPOSE 8080
CMD go run /app/main.go