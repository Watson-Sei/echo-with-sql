FROM golang:1.22.0 AS builder
WORKDIR /api
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
RUN apk add --no-cache curl
RUN apk add --no-cache make
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.0/migrate.linux-amd64.tar.gz | tar xvz
RUN mv migrate /usr/local/bin/migrate
WORKDIR /root/
COPY --from=builder /api/main .
COPY db/migrations /root/db/migrations
COPY Makefile .
CMD ["./main"]