# Етап 1: Збірка додатку
FROM golang:1.16 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o myapp .

# Етап 2: Створення мінімального образу
FROM scratch

COPY --from=builder /app/myapp /

ENTRYPOINT ["/myapp"]
