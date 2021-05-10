FROM golang AS builder
WORKDIR /go-example
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /bin/go-example .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
RUN addgroup -S go-example && adduser -S go-example -G go-example
USER go-example
WORKDIR /home/go-example
COPY --from=builder /bin/go-example ./
EXPOSE 3000
ENTRYPOINT ["./go-example"]