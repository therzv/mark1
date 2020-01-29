# manis
# Build Stage
FROM golang:alpine AS build-env

#ARG BRANCH="development"
#ARG COMMIT=""
#LABEL branch=${BRANCH}
#LABEL commit=${COMMIT}

RUN apk --no-cache add build-base git bzr mercurial gcc
ADD . /build
RUN cd /build && go build -o mark1

# Final Stage
FROM alpine


ARG BRANCH="development"
ARG COMMIT=""
LABEL branch=${BRANCH}
LABEL commit=${COMMIT}
ENV COMMIT_SHA=${COMMIT}
ENV COMMIT_BRANCH=${BRANCH}

WORKDIR /app
COPY --from=build-env /build/ /app/
EXPOSE 8080
ENTRYPOINT ./mark1


