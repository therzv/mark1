# manis
# Build Stage
FROM golang:alpine AS build-env
ARG SOURCE_COMMIT                  # get it from the --build-arg
ENV SOURCE_COMMIT $SOURCE_COMMIT   # set shell variable (of the same name)
RUN apk --no-cache add build-base git bzr mercurial gcc
ADD . /build
RUN cd /build && go build -o mark1

# Final Stage
FROM alpine
WORKDIR /app
COPY --from=build-env /build/ /app/
EXPOSE 8080
ENTRYPOINT ./mark1


