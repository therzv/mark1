# Build Stage
FROM golang:alpine AS build-env
MAINTAINER SRE  of SehatQ (sre@sehatq.com)
RUN apk --no-cache add build-base git bzr mercurial gcc
ADD . /build
RUN cd /build && go build -o mark1

# Final Stage
FROM alpine
WORKDIR /app
COPY --from=build-env /build/ /app/
ENTRYPOINT ./mark1


