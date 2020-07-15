FROM golang:alpine AS build

RUN apk add --no-cache -U make git

COPY . /src/goproxy
RUN cd /src/goproxy && \
    export CGO_ENABLED=0 && \
    make

FROM golang:alpine

RUN apk add --no-cache -U git

COPY --from=build /src/goproxy/bin/goproxy /goproxy

VOLUME /go

EXPOSE 8081

ENTRYPOINT ["/goproxy"]
CMD []
