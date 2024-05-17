# Base Builder Stage
FROM golang:1.22 AS builder

WORKDIR /usr/src/app
COPY . .

RUN go build -v -o /usr/local/bin/app

# Runtime Stage
FROM ubuntu:22.04 AS runtime

COPY --from=builder /usr/local/bin/app /usr/local/bin/

CMD ["app"]
