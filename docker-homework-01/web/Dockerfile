FROM golang:alpine AS GO_BUILDER
COPY dispatcher.go .
ENV CGO_ENABLED=0
RUN go build dispatcher.go

FROM alpine
EXPOSE 80
COPY --from=GO_BUILDER /go/dispatcher .
COPY ./static ./static

CMD ["./dispatcher"]
