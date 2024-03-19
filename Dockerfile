FROM node:lts-alpine as build

WORKDIR /build

ENV GAMJA_VERSION=v1.0.0-beta.9

RUN apk add --no-cache git && \
    git clone --depth 1 --branch ${GAMJA_VERSION} https://git.sr.ht/~emersion/gamja /build && \
    npm install --include=dev && \
    npm run build

FROM nginx:1.25-alpine-slim

COPY --from=build /build/dist /usr/share/nginx/html
