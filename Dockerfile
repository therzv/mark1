# Build Stage
FROM golang:alpine AS build-env
RUN apk --no-cache add build-base git bzr mercurial gcc
ADD . /build
RUN cd /build && go build -o mark1

# Final Stage
FROM alpine
WORKDIR /app
COPY --from=build-env /build/ /app/
EXPOSE 8080
ENTRYPOINT ./mark1


