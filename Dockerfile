FROM node:lts-alpine as build

WORKDIR /build

ARG GAMJA_VERSION=v1.0.0-beta.9

RUN apk add --no-cache git && \
    git clone --depth 1 --branch ${GAMJA_VERSION} https://git.sr.ht/~emersion/gamja /build && \
    npm install --include=dev && \
    npm run build

FROM nginx:1.25-alpine-slim

LABEL org.opencontainers.image.authors="Jack Myers"
LABEL org.opencontainers.image.title="Gamja"
LABEL org.opencontainers.image.description="A simple IRC web client"
LABEL org.opencontainers.image.source="https://github.com/jmyers/projects/gamja-docker"
LABEL org.opencontainers.image.version=${GAMJA_VERSION}

COPY --from=build /build/dist /usr/share/nginx/html
