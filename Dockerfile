# build stage
FROM golang:alpine AS build-env
RUN apk --no-cache add build-base git bzr mercurial gcc
ADD . /app
RUN cd /app && go build -o goapp

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /app/ /app/
ENTRYPOINT ./goapp


